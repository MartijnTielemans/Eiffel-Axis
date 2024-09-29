extends Area2D

var health : int

@onready var myparent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	body.player_ref.amount_of_projectiles -= 1
	body.queue_free()
	if health > 1:
		print("string")
		health -= 1
	else:
		myparent.queue_free()
