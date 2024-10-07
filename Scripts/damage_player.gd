extends Area2D

@export var canDamage = true
@onready var parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if !canDamage:
		return
	
	if body is Player and not parent.player_character == null:
		parent.player_character.update_health(-1)
	elif body is Player:
		var player = get_node("/root/Level/PlayerCharacter")
		player.update_health(-1)
