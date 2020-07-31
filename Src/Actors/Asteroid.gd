extends KinematicBody2D

export var rotation_speed := deg2rad(1)
export var move_speed := 1;
export var max_angle := deg2rad(15)

var angle := deg2rad(90)
var vector := Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	angle += rand_range(-max_angle, max_angle)
	vector = move_speed*Vector2(cos(angle), sin(angle))

func _physics_process(delta: float) -> void:
	move_and_collide(vector)
	rotate(rotation_speed)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
