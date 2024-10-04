extends Area2D

@onready var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	parent.player_character.update_health(-1)
