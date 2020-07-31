extends KinematicBody2D

export var rotation_speed := deg2rad(1)
export var grapple_speed := 350
export var max_grapple = 1000

var is_grappling := false
var grapple_length := 0.0
var collided := false
var collision_point := Vector2(0, 0)

# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
func grapple(length: float, angle: float):
	var raycast = get_node("GrappleDetection")
	
	raycast.set_cast_to(Vector2(0, length))
	collision_point = raycast.get_collision_point()
	return raycast.is_colliding()
		

func _draw() -> void:
	draw_line(Vector2(0,grapple_length + 21), Vector2(0, 21), Color(255, 255, 255), 3)
	print("Drawing ")
func _process(delta: float) -> void:
	update()

func _physics_process(delta: float) -> void:
	
	#Temporary Rotation:
	rotate(rotation_speed)
	
	if Input.is_action_just_pressed("tap"):
		is_grappling = !is_grappling
	if is_grappling:
		grapple_length += grapple_speed * delta
		if grapple_length < max_grapple:
			grapple(grapple_length,global_rotation)
#	elif collided:
#
##		grapple_length -= grapple_speed
##		if grapple_length < 0.0:
##			grapple_length = 0
	
