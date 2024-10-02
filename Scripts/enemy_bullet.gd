extends Area2D

var spawnPos : Vector2
var x_speed : int
var y_speed : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += (x_speed) * delta 
	position.y += (y_speed) * delta 
