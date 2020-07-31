extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var shape = ConvexPolygonShape2D.new()
	
	shape.points.append(Vector2(0,0))
	shape.points.append(Vector2(1,0))
	shape.points.append(Vector2(1,1))
	shape.points.append(Vector2(0,1))
	
	
	
	
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
