extends KinematicBody2D

export var rotation_speed := deg2rad(0)
export var grapple_speed := 350
export var max_grapple = 500

var is_grappling := false
var grapple_length := 0.0
var grapple_dir := Vector2.DOWN
var grapple_collided := false
var collision_point := Vector2(0, 0)

# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
func grapple(length: float, angle: float):
	var raycast = get_node("GrappleDetection")
	
	raycast.set_cast_to(Vector2(0, length))
	collision_point = to_local(raycast.get_collision_point())
	grapple_collided = raycast.is_colliding()
	
func move_to_grapple():
	print("Move to grapple")
	var raycast = get_node("GrappleDetection")
	var currentpos = raycast.position

	grapple_length = currentpos.distance_to(collision_point)
	grapple_dir = currentpos.direction_to(collision_point)

	#move below:
		
func _draw() -> void:
	draw_line(
		Vector2(0, 21), 
		Vector2(grapple_length * grapple_dir.x,grapple_length * grapple_dir.y + 21), 
		Color(255, 255, 255), 
		3
	)
	draw_circle(collision_point,10,Color(255,0,0))

func _process(delta: float) -> void:
	update()

func _physics_process(delta: float) -> void:
	
	#Temporary Rotation:
	rotate(rotation_speed)
	
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
#				print(collision_point)
#				var raycast = get_node("GrappleDetection")
#				var currentpos = raycast.global_position
#				grapple_length = currentpos.distance_to(collision_point)
		else:
			#consider dissabling the raycast for performance purposes
			is_grappling = false
	elif grapple_collided:
		move_to_grapple()

	elif grapple_length > 0.0:
		grapple_length -= grapple_speed * delta
		if grapple_length < 0:
			grapple_length = 0
		


func _on_asteroid_entered(body: Node) -> void:
	print ("Asteroid collission detected. ")
	pass # Replace with function body.
