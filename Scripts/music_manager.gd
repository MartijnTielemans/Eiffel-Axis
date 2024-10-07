extends Node2D

func play_sound_effect(sound: String):
	$AudioStreamPlayer2D.stream = load("res://Audio/" + sound + ".wav")
	if sound == "EnemyDestroyed":
		$AudioStreamPlayer2D.volume_db = -10
	else:
		$AudioStreamPlayer2D.volume_db = 0
	$AudioStreamPlayer2D.play()
	

func stop_sound_effect():
	$AudioStreamPlayer2D.stop()

func play_enemy_shoot():
	#$AudioStreamPlayer2D.stream = load("res://Audio/EnemyShoot.wav")
	$EnemyShootingSounds.play()

func play_player_bullet_sound_effect(sound: String):
	$PlayerBulletNoises.stream = load("res://Audio/" + sound + ".wav")
	if sound == "EnemyHit":
		$PlayerBulletNoises.stream = load("res://Audio/" + sound + ".mp3")
	$PlayerBulletNoises.play()
	
