extends Node2D


@onready var vis: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 200
var SPEED = 45
@export var start_left : bool

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos

func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
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
	for i in 4:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		var shoot_dir = 1
		$AudioStreamPlayer2D.play()
		if i > 1:
			shoot_dir = -1
		projectile_instance.x_speed = (((i+1)%2)*shoot_dir)*75
		projectile_instance.y_speed = ((i%2)*shoot_dir)*75
		projectile_instance.spawnPos = Vector2(global_position.x+((((i+1)%2)*shoot_dir)*10),global_position.y+((i%2)*shoot_dir)*10) 
		level.add_child(projectile_instance)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$AnimationPlayer.play("Movement")
	SPEED = 30

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimationPlayer.stop()
	SPEED = 45
