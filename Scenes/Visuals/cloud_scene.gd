extends Sprite2D

var moveSpeed = 10
@export var initialDirectionMult = -1

func initialize(pos: Vector2, playerDirection: bool) -> void:
	position = pos
	if (!playerDirection):
		initialDirectionMult = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += moveSpeed * initialDirectionMult * delta
	
	# Check if off screen
	if (position.x > 360 || position.x < -40):
		queue_free()
