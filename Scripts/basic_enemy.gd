extends Node2D


@export var y_movement = 50
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 100
const SPEED = 45
var move_up : bool
var start_left : bool

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 3
	global_position = spawn_pos
	$Sprite2D.flip_h = start_left

func _physics_process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= SPEED * delta * dir
	position.y += y_movement * delta * ((int(move_up)*2)-1)

func lose_points():
	awarded_points = 0

func die():
	spawner_ref.update_enemy_count(-1,awarded_points)
	queue_free()
