extends AnimatedSprite2D

var SPEED = 0.4


func _process(delta: float) -> void:
	position.y += SPEED*delta
