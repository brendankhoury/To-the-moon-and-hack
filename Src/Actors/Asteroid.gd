extends KinematicBody2D

export var rotation_speed := deg2rad(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta: float) -> void:
	rotate(rotation_speed)

