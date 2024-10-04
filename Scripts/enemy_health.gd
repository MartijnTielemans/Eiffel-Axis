extends Area2D

var health : int

@onready var myparent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		body.destroy_self()
		if health > 1:
			health -= 1
		else:
			myparent.die()
			
