extends KinematicBody2D

var MIN_GRAPPLE_LENGTH: float = 30.0

export var rotation_speed := deg2rad(0)
export var grapple_speed: float = 350
export var max_grapple = 500

var is_grappling: bool = false
var grapple_length: float = MIN_GRAPPLE_LENGTH
var grapple_dir: Vector2 = Vector2.DOWN
var grapple_collided: bool = false

var collision_point: Vector2 = Vector2(0, 0)
var global_collision_point: Vector2
var stuck: bool= true

var grapple_rotate_clockwise:bool = true

var asteroid : Node2D

var velocity := Vector2.ZERO

var mouse_dir : Vector2
# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
func grapple(length: float):
	var raycast = get_node("GrappleDetection")
	
	raycast.set_cast_to(length*mouse_dir)
	if raycast.is_colliding() and raycast.get_collider() == get_parent():
		is_grappling = false
	else:
		grapple_collided = raycast.is_colliding()
	if grapple_collided:
		asteroid = raycast.get_collider()
		collision_point = asteroid.to_local(raycast.get_collision_point())
		global_collision_point = asteroid.to_global(collision_point)
		
func _draw() -> void:
	
	if grapple_collided:
		draw_line(
			Vector2(0, 0), 
			to_local(global_collision_point), 
			Color(255, 255, 255), 
			3
		)
	else:
		draw_line(
			Vector2(0, 0), 
			grapple_length*mouse_dir, 
			Color(255, 255, 255), 
			3
		)

func _process(_delta: float) -> void:
	update()

func _physics_process(delta: float) -> void:
	var raycast = get_node("GrappleDetection")	
	
	if !grapple_collided:
		#raycast and snap and rotate mouse_dir
		pass
		
	
	if Input.is_action_just_released("tap"):
		mouse_dir = to_local(get_global_mouse_position()).normalized()
		if is_grappling:
			is_grappling = false
		elif !is_grappling && grapple_length == MIN_GRAPPLE_LENGTH:
			is_grappling = true
		
	if is_grappling:
		if grapple_length < max_grapple:
			grapple_length += delta * grapple_speed
			grapple(grapple_length)
			if (grapple_collided):
				is_grappling = false
		else:
			#consider dissabling the raycast for performance purposes
			is_grappling = false
	elif grapple_collided:
		global_collision_point = asteroid.to_global(collision_point)

		grapple_length = raycast.global_position.distance_to(global_collision_point)
		grapple_dir = raycast.global_position.direction_to(global_collision_point)
		position += grapple_speed * grapple_dir * delta
		grapple_length -= grapple_speed * delta
	elif grapple_length > MIN_GRAPPLE_LENGTH:
		grapple_length -= grapple_speed * delta
		if grapple_length < MIN_GRAPPLE_LENGTH:
			grapple_length = MIN_GRAPPLE_LENGTH
	elif Input.is_action_pressed("tap"):
		mouse_dir = to_local(get_global_mouse_position()).normalized()
		var mouse_raycast: RayCast2D = get_node("Mouse Raycast")
		mouse_raycast.set_global_position(get_global_mouse_position())
		mouse_raycast.set_cast_to(get_parent().get_global_position())
		
		var sprite_edges: Navigation2D = get_parent().get_node("SpriteEdges")
		var path = sprite_edges.get_simple_path(
			get_parent().to_local(to_global(position)), get_parent().to_local(get_global_mouse_position()))
		print(path)
		
func _on_asteroid_entered(body: Node) -> void:
	if  asteroid == body:
		grapple_collided = false
		grapple_length = MIN_GRAPPLE_LENGTH
		var previous_global_position := global_position
		if self.get_parent():
			self.get_parent().remove_child(self)
		body.add_child(self)
		set_global_position(previous_global_position)
		rotate(-get_parent().rotation_speed)
