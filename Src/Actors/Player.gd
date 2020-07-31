extends KinematicBody2D

export var rotation_speed := deg2rad(1)

# https://godotengine.org/qa/30772/how-to-create-a-grappling-hook-2d
# https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html

func grapple(rotation: float):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100))
	print("Grapple function called, rotation: ", int(rad2deg(rotation))%360);

func _physics_process(delta: float) -> void:
	
	#Temporary Rotation:
	
	rotate(rotation_speed)
	if Input.is_action_just_pressed("tap"):
		grapple(rotation)

