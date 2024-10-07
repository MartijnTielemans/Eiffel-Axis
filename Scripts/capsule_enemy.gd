extends Node2D
class_name Capsule

var bullet_dir = null
@export var start_left : bool
@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character : CharacterBody2D
var spawn_pos : Vector2 = Vector2(-9999,-9999)
var spawner_ref : Node2D
var awarded_points = 0
var images = []
const SPEED = 45
var spawn_pickup = true

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 1
	if not spawn_pos == Vector2(-9999,-9999):
		global_position = spawn_pos
	images.append(load("res://Assets/Enemies/Enemy_CapsuleOpen_Top.png"))
	images.append(load("res://Assets/Enemies/Enemy_CapsuleOpen_Bottom.png"))

func _process(delta: float) -> void:
	var dir = ((int(start_left)*-2)+1)
	position.x -= SPEED * delta * dir

func flip_image():
	$Sprite2D.flip_h = !$Sprite2D.flip_h
func lose_points():
	awarded_points = 0
	spawn_pickup = false
	
func die():
	if not spawner_ref == null:
		spawner_ref.update_enemy_count(-1,awarded_points)
	if spawn_pickup:
		for i in 2:
			var object_to_spawn = load("res://Scenes/Enemy/CapsulePiece.tscn")
			var instanced_object = object_to_spawn.instantiate()
			instanced_object.global_position = global_position					 #change this to where you want it to spawn
			instanced_object.x_speed = 30
			instanced_object.y_speed = (-100+(i*100))
			instanced_object.image = images[i]
			instanced_object.dir = bullet_dir
			level.add_child(instanced_object)
		var dir = ((int(start_left)*-2)+1)
		var object_to_spawn = load("res://Scenes/Enemy/PickUp.tscn")
		var instanced_object = object_to_spawn.instantiate()
		instanced_object.global_position = global_position					 #change this to where you want it to spawn
		instanced_object.speed = -SPEED * dir
		level.add_child(instanced_object)
	queue_free()
