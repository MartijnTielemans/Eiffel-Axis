extends CharacterBody2D

var spawner_ref : Node2D
var movement_mode := MoveMode.IDLE
enum MoveMode {IDLE, BETWEEN, MOVING}

@export var health : int
@export var bulletOrigin : Node2D

# Movement Variables
var canMove = false
var timeElapsed : float
var startYPos : float
@export var minMoveTime : float = 10
@export var maxMoveTime : float = 25

@export var rightXPos : float = 301
@export var leftXPos : float = 19

@export var sinSpeed : float = 3
@export var sideSwitchSpeed : float = 6

func _ready() -> void:
	$health.health = health
	
	startYPos = global_position.y
	$StartMovementTimer.start()

func _process(delta: float) -> void:
	timeElapsed += delta
	if !canMove:
		return
	
	if movement_mode == MoveMode.IDLE:
		global_position.y = startYPos + sin(timeElapsed * sinSpeed) * 45
	elif movement_mode == MoveMode.MOVING:
		print("MOVING")


func die():
	# Trigger player won functionality
	print("WIN")
	pass


func _on_start_movement_timer_timeout() -> void:
	$MoveModeTimer.wait_time = randf_range(minMoveTime, maxMoveTime)
	$MoveModeTimer.start()
	canMove = true

func _on_move_mode_timer_timeout() -> void:
	movement_mode = MoveMode.BETWEEN
