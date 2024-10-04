extends Node2D

@onready var player_character : CharacterBody2D
var spawn_pos : Vector2
var spawner_ref : Node2D
var awarded_points = 0
var level : Node2D
var images = []
const SPEED = 45

func _ready():
	var healthref = get_node("EnemyHealth")
	healthref.health = 1
	global_position = spawn_pos
	images.append(load("res://Assets/Enemies/Enemy_CapsuleOpen_Top.png"))
	images.append(load("res://Assets/Enemies/Enemy_CapsuleOpen_Bottom.png"))

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func flip_image():
	$Sprite2D.flip_h = !$Sprite2D.flip_h

func die():
	spawner_ref.current_enemies -= 1
	spawner_ref.points += awarded_points
	spawner_ref.update_points()
	if spawner_ref.current_enemies < 1:
		spawner_ref.current_wave += 1
		spawner_ref.start_new_wave()
	for i in 2:
		var object_to_spawn = load("res://Scenes/Enemy/CapsulePiece.tscn")
		var instanced_object = object_to_spawn.instantiate()
		instanced_object.global_position = global_position					 #change this to where you want it to spawn
		instanced_object.x_speed = 30
		instanced_object.y_speed = (-100+(i*100))
		instanced_object.image = images[i]
		level.add_child(instanced_object)
	var object_to_spawn = load("res://Scenes/Enemy/PickUp.tscn")
	var instanced_object = object_to_spawn.instantiate()
	instanced_object.global_position = global_position					 #change this to where you want it to spawn
	instanced_object.speed = -SPEED
	level.add_child(instanced_object)
	queue_free()
