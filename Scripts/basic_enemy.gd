extends Node2D

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3

const SPEED = 75

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
