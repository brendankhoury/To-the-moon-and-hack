extends KinematicBody2D

export var rotation_speed := deg2rad(1)
export var move_speed := 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta: float) -> void:
	move_and_collide(Vector2.DOWN)
	rotate(rotation_speed)

