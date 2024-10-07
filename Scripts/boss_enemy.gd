extends Node2D

var player_character
var spawner_ref : Node2D
var movement_mode := MoveMode.IDLE
enum MoveMode {IDLE, BETWEEN, MOVING}

@export var awarded_points : int = 3000

@export var health : int
@export var bulletOrigin : Node2D
@export var enemyToSpawn : PackedScene
var direction : int = -1

# Movement Variables
var canMove = false
var timeElapsed : float
var sideSwitchTime : float
var startYPos : float
var switchStartPos : Vector2
var moveTargetPos : Vector2

@export var minMoveTime : float = 9
@export var maxMoveTime : float = 15

@export var rightXPos : float = 301
@export var leftXPos : float = 19

@export var sinSpeed : float = 3
@export var sideSwitchSpeed : float = 6

# Attack variables
var canShoot = false
var canSpawnEnemy = false
var fourBulletsYSpace : float = 11
@export var enemyPosLU : Vector2
@export var enemyPosLD : Vector2
@export var enemyPosRU : Vector2
@export var enemyPosRD : Vector2

func _ready() -> void:
	$health.health = health
	
	startYPos = global_position.y
	$StartMovementTimer.start()

func _process(delta: float) -> void:
	timeElapsed += delta
	if !canMove:
		return
	
	if movement_mode == MoveMode.IDLE: # Sin wave up and down while attacking
		global_position.y = startYPos + sin(timeElapsed * sinSpeed) * 45
		if canShoot:
			shoot_four()
			canShoot = false
			$AttackCoolDownTimer.start()
	
	elif movement_mode == MoveMode.MOVING: # Move to the other side
		sideSwitchTime += delta * 0.3
		if sideSwitchTime > 1:
			sideSwitchTime = 1
		position = lerp(switchStartPos, moveTargetPos, sideSwitchTime)
		# If target position is reached, start timer and go to idle again
		if position == moveTargetPos || sideSwitchTime == 1:
			movement_mode = MoveMode.BETWEEN
			$SwitchedWaitTime.start()

# Shoots four bullets
func shoot_four():
	MusicManager.play_enemy_shoot()
	for i in 4:
		var projectile = load("res://Scenes/Enemy/EnemyBullet.tscn")
		var projectile_instance = projectile.instantiate()
		var bulletOffset = i * fourBulletsYSpace
		
		projectile_instance.spawnPos.x = bulletOrigin.global_position.x
		projectile_instance.spawnPos.y = bulletOrigin.global_position.y + bulletOffset
		projectile_instance.y_speed = 0
		projectile_instance.x_speed = 85 * direction
		get_tree().get_root().get_node("Level").add_child(projectile_instance)

# Spawns enemies from two corners
func spawn_enemies():
	var alreadyPicked : int = 9
	for i in 2:
		var enemy = enemyToSpawn.instantiate()
		var spawnPos : Vector2
		var rndPosIndex : int
		
		# Get a random position index that is not yet picked
		while true:
			rndPosIndex = randi_range(0, 3)
			if rndPosIndex != alreadyPicked:
				alreadyPicked = rndPosIndex
				break
		
		match rndPosIndex:
			0:
				spawnPos = enemyPosLU
				enemy.start_left = true
			1:
				spawnPos = enemyPosLD
				enemy.start_left = true
			2:
				spawnPos = enemyPosRU
				enemy.start_left = false
			3:
				spawnPos = enemyPosRD
				enemy.start_left = false
			_:
				spawnPos = enemyPosLU
				enemy.start_left = true
		
		enemy.global_position = spawnPos
		get_tree().get_root().get_node("Level").add_child(enemy)


func die():
	# Trigger player won functionality
	var UI_ref = get_node("/root/Level/Control")
	UI_ref.update_points(awarded_points)
	get_node("/root/Level/PlayerCharacter").game_over_win()
	queue_free() # Replace with sequence later


# Turns the boss. Scales -1 and sets direction
func TurnAround():
	$Rotator.scale.x = -$Rotator.scale.x
	direction = -direction

func StartMovingSides():
	$SwitchedWaitTime.start()

func StartMoveModeTimer():
	$MoveModeTimer.wait_time = randf_range(minMoveTime, maxMoveTime)
	$MoveModeTimer.start()

# Timers Cool -----------
func _on_start_movement_timer_timeout() -> void:
	StartMoveModeTimer()
	timeElapsed = 0
	canMove = true
	canShoot = true
	$EnemySpawnCooldownTimer.start()

func _on_move_mode_timer_timeout() -> void:
	StartMovingSides()

func _on_switched_wait_time_timeout() -> void:
	sideSwitchTime = 0
	switchStartPos = position
	if movement_mode == MoveMode.IDLE:
		var xPos : float
		if direction == -1:
			xPos = leftXPos
		elif direction == 1:
			xPos = rightXPos
		
		moveTargetPos = Vector2(xPos, startYPos) # set target position
		movement_mode = MoveMode.MOVING # Set movement to moving
	elif movement_mode == MoveMode.BETWEEN:
		TurnAround()
		timeElapsed = 0
		movement_mode = MoveMode.IDLE
		StartMoveModeTimer()

func _on_attack_cool_down_timer_timeout() -> void:
	canShoot = true

func _on_enemy_spawn_cooldown_timer_timeout() -> void:
	spawn_enemies()
	canSpawnEnemy = false
