extends Node2D

@onready var level = get_tree().get_root().get_node("Level")
@export var y_movement = 50
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 300
const SPEED = 45
@export var look_up : bool
@export var start_left : bool

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos
	$Sprite2D.flip_v = look_up

func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= SPEED * delta * dir

func shoot():
	var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
	var projectile_instance = projectile.instantiate()
	projectile_instance.y_speed = (-75*((int(look_up)*2)-1))
	var dir = ((int(start_left)*-2)+1)
	projectile_instance.x_speed = -45 * dir
	projectile_instance.spawnPos = global_position
	level.add_child(projectile_instance)

func lose_points():
	awarded_points = 0

func die():
	if not spawner_ref == null:
		spawner_ref.update_enemy_count(-1,awarded_points)
	else:
		var UI_ref = get_node("/root/Level/Control")
		UI_ref.update_points(awarded_points)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$AnimationPlayer.play("Movement")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimationPlayer.stop()
