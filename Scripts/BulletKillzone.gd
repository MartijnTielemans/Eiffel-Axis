extends Area2D

#Saves a reference to the player on ready
@onready var player_character: CharacterBody2D = $"../PlayerCharacter"

#when something enters the collision, player's amount of projectiles goes down
func _on_body_entered(body: CharacterBody2D) -> void:
	player_character.update_projectile_amount(-1)
	body.queue_free()
