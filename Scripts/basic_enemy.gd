extends Node2D

@onready var player_character : CharacterBody2D
var spawn_pos : Vector2

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 1
	global_position = spawn_pos

const SPEED = 50

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
