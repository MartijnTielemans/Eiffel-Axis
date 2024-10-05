extends Node2D

@export var y_movement = 50
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 100
var SPEED = 45
@export var move_up : bool
@export var start_left : bool

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos
	$Sprite2D.flip_h = start_left


func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	global_position.x -= SPEED * delta * dir
	global_position.y += y_movement * delta * ((int(move_up)*2)-1)

func lose_points():
	awarded_points = 0

func die():
	if not spawner_ref == null:
		spawner_ref.update_enemy_count(-1,awarded_points)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$AnimationPlayer.play("Movement")
