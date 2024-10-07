extends Control

@export var firstSelectedButton : TextureButton
@export var settingsMenu : CanvasItem

func Continue():
	$".".visible = false
	get_tree().paused = false
	MusicManager.continue_music()


func Pause():
	$".".visible = true
	get_tree().paused = true
	firstSelectedButton.grab_focus()
	MusicManager.continue_music()


func _process(delta: float) -> void:
	PauseButton()


func PauseButton():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		Pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		Continue()


func _on_continue_pressed() -> void:
	Continue()
	MusicManager.play_special("CursorSelect")

func _on_settings_pressed() -> void:
	SetButtonFocus(false)
	settingsMenu.visible = true
	settingsMenu.ReturnFirstButton().grab_focus();
	MusicManager.play_sound_effect("CursorSelect")


func _on_exit_pressed() -> void:
	get_tree().paused = false
	SceneTransition.transitionOver.connect(load_scene);
	SceneTransition.Transition(true);
	MusicManager.play_sound_effect("CursorSelect")


func load_scene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Menus/MenuMain.tscn");


func SetButtonFocus(focus : bool):
	if (focus):
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Continue.focus_mode = FOCUS_ALL
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Settings.focus_mode = FOCUS_ALL
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Exit.focus_mode = FOCUS_ALL
	else:
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Continue.focus_mode = FOCUS_NONE
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Settings.focus_mode = FOCUS_NONE
		$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Exit.focus_mode = FOCUS_NONE


func _on_settings_menu_close_panel() -> void:
	settingsMenu.visible = false
	SetButtonFocus(true)
	$BoxContainer/NinePatchRect/NinePatchRect/VBoxContainer/Settings.grab_focus()
	
	


func _input(event):
	if not InputEventJoypadMotion and (event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right")):
		MusicManager.play_sound_effect("CursorMove")

func _unhandled_input(event):
	if not event.is_action_released("ui_accept") and not event.is_action_released("ui_down") and not event.is_action_released("ui_up") and not event.is_action_released("ui_left") and not event.is_action_released("ui_right"):
		MusicManager.stop_sound_effect()

func _on_continue_mouse_entered() -> void:
		MusicManager.play_sound_effect("CursorMove")


func _on_settings_mouse_entered() -> void:
		MusicManager.play_sound_effect("CursorMove")


func _on_exit_mouse_entered() -> void:
		MusicManager.play_sound_effect("CursorMove")
