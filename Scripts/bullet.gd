extends CharacterBody2D
const SPEED = 250
var spawnPos : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(spawnPos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += SPEED * delta
