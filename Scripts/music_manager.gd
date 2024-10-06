extends Node2D

func play_sound_effect(sound: String):
	$AudioStreamPlayer2D.stream = load("res://Audio/" + sound + ".wav")
	$AudioStreamPlayer2D.play()

func stop_sound_effect():
	$AudioStreamPlayer2D.stop()
