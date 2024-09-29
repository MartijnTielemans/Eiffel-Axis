extends AnimatedSprite2D

var SPEED = 0.2


func _process(delta: float) -> void:
	position.y += SPEED*delta
