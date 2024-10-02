extends Node2D

@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 100

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	global_position = spawn_pos


const SPEED = 50

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func die():
	spawner_ref.current_enemies -= 1
	spawner_ref.points += awarded_points
	spawner_ref.update_points()
	if spawner_ref.current_enemies < 1:
		spawner_ref.current_wave += 1
		spawner_ref.start_new_wave()
	queue_free()
