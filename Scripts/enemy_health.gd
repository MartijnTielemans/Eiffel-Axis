extends Area2D

var health : int

@onready var myparent = get_parent()
@export var destroyParticles : Array[PackedScene]

func _on_body_entered(body: Node2D) -> void:
	body.player_ref.amount_of_projectiles -= 1
	body.queue_free()
	if health > 1:
		pass
		health -= 1
	else:
		for i in destroyParticles:
			var particle : CPUParticles2D = i.instantiate()
			particle.position = myparent.position
			get_tree().root.add_child(particle)
			particle.emitting = true
		
		myparent.die()
		
