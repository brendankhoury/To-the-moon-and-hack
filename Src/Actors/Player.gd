extends KinematicBody2D

export var rotation_speed := deg2rad(1)
export var grapple_speed := 3

var is_grappling := false
var grapple_length := 560.0

# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html

func grapple(length: float, angle: float):
#	var space_state = get_world_2d().direct_space_state
#	var result = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100))
	var raycast = get_node("GrappleDetection")
	
	raycast.set_cast_to(Vector2(0, length))
	var collision_point = raycast.get_collision_point ()
	print(collision_point,raycast.is_colliding()) 
#	print("Grapple function called, rotation: ", int(rad2deg(rotation))%360, collision_point);

func _physics_process(delta: float) -> void:
	
	#Temporary Rotation:
	rotate(rotation_speed)
	if Input.is_action_just_pressed("tap"):
		is_grappling = !is_grappling
	if is_grappling:
		grapple_length += grapple_speed * delta
		grapple(grapple_length,global_rotation)

