extends Control

@export var controlsPanel: BoxContainer;
@export var settingsPanel: BoxContainer;
@export var creditsPanel: BoxContainer;
@export var controlButton: TextureButton
@export var settingsButton: TextureButton
@export var creditsButton: TextureButton
var lastButtonPressed: TextureButton;
@export var highScoreText : Label


func _ready() -> void:
	# Get high score from file
	var high_score = Global.score_save.high_score
	highScoreText.text = str(high_score)

# Waits for the transition to be done before going to next scene
func _on_play_pressed() -> void:
	Global.player_won = false
	SceneTransition.transitionOver.connect(load_scene);
	SceneTransition.Transition(true);
	MusicManager.stop_sound_effect()
	MusicManager.play_sound_effect("StartGame")

# Loads the game scene
func load_scene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");

func _on_controls_pressed() -> void:
	lastButtonPressed = controlButton;
	controlsPanel.visible = true;
	get_node("PanelMenus/BoxContainer/ControlsMenu2").ReturnFirstButton().grab_focus();
	MusicManager.play_sound_effect("CursorSelect")

func _on_settings_pressed() -> void:
	lastButtonPressed = settingsButton;
	settingsPanel.visible = true;
	get_node("PanelMenus/BoxContainer2/SettingsMenu").ReturnFirstButton().grab_focus();
	MusicManager.play_sound_effect("CursorSelect")

func _on_quit_pressed() -> void:
	get_tree().quit();
	MusicManager.play_sound_effect("CursorSelect")

func _on_credits_pressed() -> void:
	lastButtonPressed = creditsButton;
	creditsPanel.visible = true;
	get_node("PanelMenus/BoxContainer3/CreditsMenu").ReturnFirstButton().grab_focus();
	MusicManager.play_sound_effect("CursorSelect")

# When a panel closes, reget focus on the last button
func _on_close_panel() -> void:
	controlsPanel.visible = false;
	settingsPanel.visible = false;
	creditsPanel.visible = false;
	lastButtonPressed.grab_focus();

func _input(event):
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		MusicManager.play_sound_effect("CursorMove")



func _unhandled_input(event):
	if not event.is_action_released("ui_accept") and not event.is_action_released("ui_down") and not event.is_action_released("ui_up") and not event.is_action_released("ui_left") and not event.is_action_released("ui_right"):
		MusicManager.stop_sound_effect()


func _on_play_mouse_entered() -> void:
	MusicManager.play_sound_effect("CursorMove")


func _on_controls_mouse_entered() -> void:
	MusicManager.play_sound_effect("CursorMove")


func _on_settings_mouse_entered() -> void:
	MusicManager.play_sound_effect("CursorMove")


func _on_credits_mouse_entered() -> void:
	MusicManager.play_sound_effect("CursorMove")


func _on_quit_mouse_entered() -> void:
	MusicManager.play_sound_effect("CursorMove")
