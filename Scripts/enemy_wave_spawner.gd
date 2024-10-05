extends Node2D

@onready var level = get_tree().get_root().get_node("Level")
@onready var player_character: CharacterBody2D = $"../PlayerCharacter"
@onready var UI_ref = $"../Control"
var current_wave : float = 0
var waves = [
	"Wave1",
	"Wave2",
	"Wave3",
	]
var current_enemies : int
var points : int


func update_points():
	UI_ref.points = points
	UI_ref.update_points()
#if there is another wave in array "waves" it will start a new wave
func start_new_wave():
	if current_wave < len(waves):
		$AnimationPlayer.play(waves[current_wave])
		print(current_wave/float(len(waves)))
		UI_ref.progress = (current_wave/float(len(waves)))
		UI_ref.update_progress()
	else:
		UI_ref.progress = (current_wave/float(len(waves)))
		UI_ref.update_progress()

func update_enemy_count(change: int,awarded_points: int):
	current_enemies -= 1
	points += awarded_points
	update_points()
	if current_enemies < 1:
		current_wave += 1
		start_new_wave()

#spawns the basic enemy and gives it the needed variables
func spawn_flyer_enemy(Location: Vector2, start_left: bool,move_up: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/BasicEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.move_up = move_up
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	current_enemies += 1
	level.add_child(instanced_enemy)

#spawns the shooter enemy and gives it the needed variables
func spawn_quad_enemy(Location: Vector2, start_left: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/ShooterEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	current_enemies += 1
	level.add_child(instanced_enemy)

func spawn_wavy_enemy(Location: Vector2, start_left: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/SwoopEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	current_enemies += 1
	level.add_child(instanced_enemy)

func spawn_tank_enemy(Location: Vector2, start_left: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/TankEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	current_enemies += 1
	level.add_child(instanced_enemy)

func spawn_capsule(Location: Vector2, start_left: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/CapsuleEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	instanced_enemy.level = level
	current_enemies += 1
	level.add_child(instanced_enemy)
	
func spawn_block(Location: Vector2, start_left: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/Block.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	current_enemies += 1
	level.add_child(instanced_enemy)

func spawn_turret(Location: Vector2, start_left: bool, look_up: bool):
	var enemy_to_spawn = load("res://Scenes/Enemy/TurretEnemy.tscn")
	var instanced_enemy = enemy_to_spawn.instantiate()
	instanced_enemy.player_character = player_character
	instanced_enemy.spawn_pos = Location					 #change this to where you want it to spawn
	instanced_enemy.start_left = start_left
	instanced_enemy.spawner_ref = self
	instanced_enemy.look_up = look_up
	current_enemies += 1
	level.add_child(instanced_enemy)
