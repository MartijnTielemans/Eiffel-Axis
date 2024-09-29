extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");

func _on_controls_pressed() -> void:
	print("Controls");

func _on_settings_pressed() -> void:
	print("Settings");

func _on_quit_pressed() -> void:
	get_tree().quit();
