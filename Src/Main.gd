extends Node

export (PackedScene) var Asteroid
var score : int = 0

func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	pass
	
func _on_AsteroidSpawnTimer_timeout():
	# Choose a random location on Path2D.
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var asteroid = Asteroid.instance()
	add_child(asteroid)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	asteroid.position = $AsteroidPath/AsteroidSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

func _on_Timer_timeout():
	score = score + 1
	get_node("UI").get_node("Label").text = "Score: " + str(score)

