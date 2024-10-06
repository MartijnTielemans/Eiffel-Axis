extends CharacterBody2D
class_name Player

@onready var level = get_tree().get_root().get_node("Level")
@onready var UI_ref = $"../Control"

const SPEED = 800				#how much the character speeds up per second
const x_maxspeed = 120			#Max X speed the player can have
const y_maxspeed = 100			#Max Y speed the player can have
const MaxBullets = 3			#Max amount of bullets that can be on screen at once
var X_SPEED = 0
var Y_SPEED = 0
@export var HP = 3
var amount_of_projectiles = 0
var is_pivoting
var dir = 1
var I_frames = false
var sprites : Array[String] = [
	"fly_up",
	"default",
	"fly_down",
	]

var shootParticleXPos:float #Initial Particle position
signal on_death

func _ready() -> void:
	shootParticleXPos = $ShootParticle.position.x

func _process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	#horizontal movement
	var X_input:= Input.get_axis("move_left", "move_right")
	if X_input:
		X_SPEED += X_input * SPEED * delta
		X_SPEED = clamp(X_SPEED,-x_maxspeed * int(Input.is_action_pressed("move_left")), x_maxspeed * int(Input.is_action_pressed("move_right")))
		velocity.x = X_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		X_SPEED = 0
	#vertical movement
	var Y_input:= Input.get_axis("move_up", "move_down")
	if Y_input:
		if !is_pivoting:
			$AnimatedSprite2D.play(sprites[Y_input+1])
		Y_SPEED += Y_input * SPEED * delta
		Y_SPEED = clamp(Y_SPEED,-y_maxspeed * int(Input.is_action_pressed("move_up")), y_maxspeed * int(Input.is_action_pressed("move_down")))
		velocity.y = Y_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		Y_SPEED = 0
		if !is_pivoting:
			$AnimatedSprite2D.play("default")
	move_and_slide()
	
	#Shooting
	var is_shooting = Input.is_action_pressed("shoot")
	var want_to_flip = Input.is_action_pressed("pivot")
	if want_to_flip:
		$AnimationPlayer.play("PivotPlayer")
	elif is_shooting and !is_pivoting:
		$AnimationPlayer.play("Shooting")
	
	#check wether being crushed
	if $RayCast2D_L.is_colliding() and $RayCast2D_R.is_colliding():
		if $RayCast2D_R.get_collider() is Block:
			var collidedBlock = $RayCast2D_R.get_collider()
			collidedBlock.queue_free()
		if $RayCast2D_L.get_collider() is Block:
			var collidedBlock = $Raycast2D_L.get_collider()
			collidedBlock.queue_free()
		update_health(-1)
		#print("Colliding")
		#var Colliding_objectL = $RayCast2D_L.get_collider()
		#if Colliding_objectL.get_parent().is_class("Block"):
			#print("LEFT")
			#var Colliding_Block = $RayCast2D_L.get_collider()
			#Colliding_Block.destroy_self
		#var Colliding_objectR = $RayCast2D_R.get_collider()
		#if Colliding_objectL.get_parent().is_class("Block"):
			#print("RIGHT")
			#var Colliding_Block = $RayCast2D_R.get_collider()
			#Colliding_Block.destroy_self
		#update_health(-1)

	#This is triggered by the AnimationPlayer
func shoot_projectile():
	if amount_of_projectiles < MaxBullets:
		var projectile = load("res://Scenes/Bullet.tscn")
		var projectile_instance = projectile.instantiate()
		projectile_instance.spawnPos = global_position 
		projectile_instance.player_ref = self
		projectile_instance.dir = dir
		amount_of_projectiles += 1
		level.add_child(projectile_instance)
		$AudioStreamPlayer2D.play()
		$ShootParticle.emitting = true

func pivot_player_animation():
	is_pivoting = true
	$AnimatedSprite2D.play("pivot")
	

func update_projectile_amount(projectile_change: int):
	amount_of_projectiles += projectile_change
	clamp(amount_of_projectiles,0,MaxBullets)

func pivot_player():
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	dir = ((int($AnimatedSprite2D.flip_h)*-2)+1)
	
	# Set shoot particle position
	$ShootParticle.position.x = shootParticleXPos * dir
	$ShootParticle.direction.x = dir
	
func end_pivot_player():
	is_pivoting = false
	
func update_health(health_change: int):
	if I_frames == false:
		HP += health_change
		UI_ref.health = HP
		UI_ref.update_visuals()
		$HurtParticle.emitting = true
		if HP == 0:
			# Signal Game Over
			MusicManager.play_sound_effect("GameOver")
			on_death.emit()
			SceneTransition.transitionOver.connect(load_scene);
			SceneTransition.Transition(true);
		else:
			MusicManager.play_sound_effect("PlayerDamage")
			I_frames = true
			$Timer.start()
			$RepeatingTimer.start()
		


func visualise_Iframes():
	if I_frames == true:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		$AnimationPlayer.play("I_frames")
	else:
		$AnimatedSprite2D.visible = true

# Loads the game scene
func load_scene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Menus/GameOverScreen.tscn");

func _on_timer_timeout() -> void:
	I_frames = false

func _on_repeating_timer_timeout() -> void:
	if I_frames == true:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
	else:
		$AnimatedSprite2D.visible = true
		$RepeatingTimer.stop()
