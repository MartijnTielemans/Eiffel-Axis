extends Area2D

@onready var player_character: CharacterBody2D = $"../PlayerCharacter"


func _on_body_entered(body: Node2D) -> void:
	player_character.amount_of_projectiles -= 1
