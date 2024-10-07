extends Node2D


@export var y_movement = 50
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 200
var SPEED = 45
@export var moveSpeed : float = 70
@export var start_left : bool


func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 1
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos
	$Sprite2D.flip_h = start_left

func _physics_process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= SPEED * delta * dir
	if SPEED == moveSpeed:
		position.y += sin(position.x/25)
		if (sin(position.x/25)>0.5):
			$Sprite2D.texture = preload("res://Assets/Enemies/Enemy_Wavy_Down.png")
		elif (sin(position.x/25)<-0.5):
			$Sprite2D.texture = preload("res://Assets/Enemies/Enemy_Wavy_Up.png")
		else:
			$Sprite2D.texture = preload("res://Assets/Enemies/Enemy_Wavy.png")

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
	SPEED = moveSpeed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	SPEED = 45
