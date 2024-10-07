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
	if sound == "EnemyHit":
		$PlayerBulletNoises.stream = load("res://Audio/" + sound + ".mp3")
	else:
		$PlayerBulletNoises.stream = load("res://Audio/" + sound + ".wav")
	$PlayerBulletNoises.play()

func play_music(song: String):
	$MusicPlayer.stream = load("res://Audio/Songs/" + song + ".wav")
	$MusicPlayer.play()

func play_special(sound: String):
	$SpecialSounds.stream = load("res://Audio/" + sound + ".wav")
	$SpecialSounds.play()

func continue_music():
	$MusicPlayer.play
