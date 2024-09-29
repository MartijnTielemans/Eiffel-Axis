extends Node2D

@onready var level = get_tree().get_root().get_node("Level")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_basic_enemy(Location: Vector2):
	var enemy_to_spawn = load("res://Scenes/Enemy/BasicEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.spawn_pos = Location #change this to where you want it to spawn
	level.add_child(instanced_enemy)
