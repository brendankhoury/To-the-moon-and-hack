extends KinematicBody2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("tap"):
		print("Tap detected")
