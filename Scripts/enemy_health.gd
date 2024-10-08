extends Area2D

var health : int

@onready var myparent = get_parent()
@export var destroyParticles : Array[PackedScene]

func _on_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		if myparent is Capsule:
			myparent.bullet_dir = body.dir
		body.destroy_self()
		if health > 1:
			health -= 1
			MusicManager.play_player_bullet_sound_effect("EnemyHit")
		else:
			emit_particles()
			MusicManager.play_special("EnemyDestroyed")
			myparent.die()

func emit_particles():
	for i in destroyParticles:
		var particle : CPUParticles2D = i.instantiate()
		particle.global_position = myparent.global_position
		get_tree().root.add_child(particle)
		particle.emitting = true
