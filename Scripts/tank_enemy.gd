extends Node2D

@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 300
const SPEED = 45
@export var moving = true

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 7
	global_position = spawn_pos

func _physics_process(delta: float) -> void:
	if moving == true:
		position.x -= SPEED * delta

func die():
	spawner_ref.current_enemies -= 1
	spawner_ref.points += awarded_points
	spawner_ref.update_points()
	if spawner_ref.current_enemies < 1:
		spawner_ref.current_wave += 1
		spawner_ref.start_new_wave()
	queue_free()

func shoot():
	for i in 3:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		projectile_instance.y_speed = (i-1)*35
		projectile_instance.x_speed = -75
		projectile_instance.spawnPos = global_position
		level.add_child(projectile_instance)
