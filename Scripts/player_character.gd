extends CharacterBody2D

@onready var level = get_tree().get_root().get_node("Level")

const SPEED = 800				#how much the character speeds up per second
const x_maxspeed = 100			#Max X speed the player can have
const y_maxspeed = 80			#Max Y speed the player can have
const MaxBullets = 3			#Max amount of bullets that can be on screen at once
var X_SPEED = 0
var Y_SPEED = 0
var amount_of_projectiles = 0
var sprites : Array[String] = [
	"fly_up",
	"default",
	"fly_down",
	]

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
		$AnimatedSprite2D.play(sprites[Y_input+1])
		Y_SPEED += Y_input * SPEED * delta
		Y_SPEED = clamp(Y_SPEED,-y_maxspeed * int(Input.is_action_pressed("move_up")), y_maxspeed * int(Input.is_action_pressed("move_down")))
		velocity.y = Y_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		Y_SPEED = 0
		$AnimatedSprite2D.play("default")
	move_and_slide()
	
	#Shooting
	var is_shooting = Input.is_action_pressed("shoot")
	if is_shooting:
		$AnimationPlayer.play("Shooting")
	
	#This is triggered by the ShootingPlayer
func shoot_projectile():
	if amount_of_projectiles < MaxBullets:
		var projectile = load("res://Scenes/Bullet.tscn")
		var Something = projectile.instantiate()
		Something.spawnPos = global_position 
		Something.player_ref = self
		amount_of_projectiles += 1
		level.add_child(Something)
