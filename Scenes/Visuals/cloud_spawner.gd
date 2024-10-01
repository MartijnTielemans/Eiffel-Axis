extends Node2D

@export var cloudScene: PackedScene

var timerMin = 3.5
var timerMax = 7.5

var spawnMin = 18
var spawnMax = 105

var currentPlayerRotation = false

# Set the timer to a random amount to start with and start
func _ready() -> void:
	randomize()
	$SpawnTimer.wait_time = randf_range(1.5, 2.4)
	$SpawnTimer.start()


# Spawns 1 to 3 clouds
func _spawn_cloud() -> void:
	randomize()
	var amountToSpawn = randi_range(1, 4)
	
	# Set spawn location. Clouds X depends on the player's rotation state
	# (From X -10 to 330)
	var cloudSpawnLocation: Vector2
	if (currentPlayerRotation):
		cloudSpawnLocation.x = 330
	else:
		cloudSpawnLocation.x = -10
	cloudSpawnLocation.y = randi_range(spawnMin, spawnMax)
	
	for i in amountToSpawn:
		var cloud = cloudScene.instantiate()
		
		var pos = cloudSpawnLocation
		pos.y += (i * 2)
		pos.x += (i * 3)
		if (i == 2):
			pos.y -= 3
		
		cloud.initialize(pos, currentPlayerRotation)
		add_child(cloud)


func _on_spawn_timer_timeout() -> void:
	_spawn_cloud()
	$SpawnTimer.wait_time = randf_range(timerMin, timerMax)
	$SpawnTimer.start()
