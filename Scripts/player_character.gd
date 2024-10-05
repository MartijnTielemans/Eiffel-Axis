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

func _ready() -> void:
	shootParticleXPos = $ShootParticle.position.x

func _physics_process(delta: float) -> void:
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
		if HP < 1:
			$HurtParticle.emitting = true
			SceneTransition.transitionOver.connect(load_scene);
			SceneTransition.Transition(true);
		else:
			I_frames = true
			$Timer.start()
			visualise_Iframes()


func visualise_Iframes():
	if I_frames == true:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		$AnimationPlayer.play("I_frames")
	else:
		$AnimatedSprite2D.visible = true

# Loads the game scene
func load_scene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Menus/MenuMain.tscn");

func _on_timer_timeout() -> void:
	I_frames = false
