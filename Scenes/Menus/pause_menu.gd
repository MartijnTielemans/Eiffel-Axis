extends Control

@export var firstSelectedButton : TextureButton

func Continue():
	$".".visible = false
	get_tree().paused = false


func Pause():
	$".".visible = true
	get_tree().paused = true
	firstSelectedButton.grab_focus()


func _process(delta: float) -> void:
	PauseButton()


func PauseButton():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		Pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		Continue()


func _on_continue_pressed() -> void:
	Continue()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().paused = false
	SceneTransition.transitionOver.connect(load_scene);
	SceneTransition.Transition(true);


func load_scene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Menus/MenuMain.tscn");
