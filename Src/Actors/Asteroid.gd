extends RigidBody2D

export var rotation_speed := 25
export var move_speed := 1;
export var max_angle := deg2rad(30)

var angle := deg2rad(90)
var vector := Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	angle += rand_range(-max_angle, max_angle)
	vector = move_speed*Vector2(cos(angle), sin(angle))
	

func _physics_process(delta: float) -> void:
	if delta < 100:
		apply_central_impulse(vector)
		apply_torque_impulse(rotation_speed)
	else:
		apply_central_impulse(Vector2(0,0))
		apply_torque_impulse(0)


func _on_Death_Box_area_entered(area: Area2D) -> void:
	if get_node("Player"):
		get_parent().get_node("Timer").stop()
		get_parent().game_over = true
	queue_free()
	pass # Replace with function body.
