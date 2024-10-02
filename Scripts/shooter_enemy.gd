extends Node2D

@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 100
const SPEED = 30

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	global_position = spawn_pos

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

func shoot():
	for i in 4:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		var dir = 1
		if i > 1:
			dir = -1
		projectile_instance.x_speed = (((i+1)%2)*dir)
		projectile_instance.y_speed = (i%2)*dir
		projectile_instance.spawnPos = Vector2(global_position.x+((((i+1)%2)*dir)*10),global_position.y+((i%2)*dir)*10) 
		level.add_child(projectile_instance)
