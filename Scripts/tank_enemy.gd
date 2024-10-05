extends Node2D


@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 300
const SPEED = 45
@export var moving = true
@export var start_left : bool
var dir : int

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 7
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos
	$Sprite2D.flip_h = start_left

func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	if moving == true:
		position.x -= SPEED * delta * dir

func lose_points():
	awarded_points = 0

func die():
	if not spawner_ref == null:
		spawner_ref.update_enemy_count(-1,awarded_points)
	else:
		var UI_ref = get_node("/root/Level/Control")
		UI_ref.update_points(awarded_points)
	queue_free()

func shoot():
	var dir = ((int(start_left)*-2)+1)
	for i in 3:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		projectile_instance.y_speed = (i-1)*35
		projectile_instance.x_speed = -75 * dir
		projectile_instance.spawnPos = global_position
		level.add_child(projectile_instance)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$AnimationPlayer.play("Movement")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimationPlayer.stop()
