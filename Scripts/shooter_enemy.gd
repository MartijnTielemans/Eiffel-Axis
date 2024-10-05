extends Node2D


@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 200
const SPEED = 30
var start_left : bool

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	global_position = spawn_pos

func _physics_process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= SPEED * delta * dir

func lose_points():
	awarded_points = 0

func die():
	spawner_ref.update_enemy_count(-1,awarded_points)
	queue_free()

func shoot():
	for i in 4:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		var shoot_dir = 1
		if i > 1:
			shoot_dir = -1
		projectile_instance.x_speed = (((i+1)%2)*shoot_dir)*75
		projectile_instance.y_speed = ((i%2)*shoot_dir)*75
		projectile_instance.spawnPos = Vector2(global_position.x+((((i+1)%2)*shoot_dir)*10),global_position.y+((i%2)*shoot_dir)*10) 
		level.add_child(projectile_instance)
