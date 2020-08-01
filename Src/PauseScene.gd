extends Node2D

var down := false
var up := false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_button_down():
	get_tree().paused = true
	down = true
	pass # Replace with function body.


func _on_TextureButton_button_up():
	if up:
		up = false
		get_tree().paused = false
	if down:
		down = false
		up = true
	pass # Replace with function body.
