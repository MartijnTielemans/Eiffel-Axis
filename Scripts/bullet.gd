extends CharacterBody2D


const SPEED = 200			#How much the bullet moves per second
var spawnPos : Vector2		#This value is set by the player_character when spawned
var player_ref : CharacterBody2D
var health = 3
# Sets the position of the bullet to the position given by the player_character

func _ready() -> void:
	global_position = Vector2(spawnPos)

# Moves the bullet to the right
func _physics_process(delta: float) -> void:
	position.x += SPEED * delta
