extends KinematicBody2D


export var rotation_speed := deg2rad(0)
export var grapple_speed: float = 350
export var max_grapple = 500

var is_grappling: bool = false
var grapple_length: float = 30.0
var grapple_dir: Vector2 = Vector2.DOWN
var grapple_collided: bool = false

var collision_point: Vector2 = Vector2(0, 0)
var stuck: bool= true

var asteroid : Node2D

var velocity := Vector2.ZERO
# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
func grapple(length: float, angle: float):
	var raycast = get_node("GrappleDetection")
	
	raycast.set_cast_to(Vector2(0, length))
	grapple_collided = raycast.is_colliding()
	if grapple_collided:
#		if abs(global_position.distance_to(raycast.get_collision_point())) < 150:
		asteroid = raycast.get_collider()
		print("C")
		
		collision_point = asteroid.to_local(raycast.get_collision_point())
#		else: 
#			grapple_length = 30
#			grapple_collided = false
#			is_grappling = false

func _draw() -> void:
	draw_line(
		Vector2(0, 0), 
		Vector2(0, grapple_length), 
		Color(255, 255, 255), 
		3
	)

func _process(_delta: float) -> void:
	update()

func _physics_process(delta: float) -> void:
	var raycast = get_node("GrappleDetection")	

	if Input.is_action_just_pressed("tap"):
		if is_grappling:
			is_grappling = false
		elif !is_grappling && grapple_length == 0:
			is_grappling = true
	if is_grappling:
		if grapple_length < max_grapple:
			grapple_length += delta * grapple_speed
			grapple(grapple_length,global_rotation)
			if (grapple_collided):
				is_grappling = false
		else:
			#consider dissabling the raycast for performance purposes
			is_grappling = false
	elif grapple_collided:
		var global_position_point = asteroid.to_global(collision_point)
		print(global_position_point)
		grapple_length = raycast.global_position.distance_to(global_position_point)
		grapple_dir = raycast.global_position.direction_to(global_position_point)
		position += grapple_speed * grapple_dir * delta
		grapple_length -= grapple_speed * delta
	elif grapple_length > 0.0:
		grapple_length -= grapple_speed * delta
		if grapple_length < 0:
			grapple_length = 0

func _on_asteroid_entered(body: Node) -> void:
	if  asteroid == body:
		grapple_collided = false
		var previous_global_position := global_position
		if self.get_parent():
			self.get_parent().remove_child(self)
		body.add_child(self)
		set_global_position(previous_global_position)
