extends Node2D


func _ready() -> void:
	Global.load_score()
	SceneTransition.Transition(true)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/MenuMain.tscn");
	SceneTransition.Transition(false)
