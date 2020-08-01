extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_up():
	
	if !started:
		get_tree().paused = false
		self.visible = false
		self.disabled = true
		self.get_node("Label").text = "Exit?"
	else:
		print(get_tree().reload_current_scene())
		
	pass # Replace with function body.
