extends Control

@export var controlsPanel: BoxContainer;
@export var settingsPanel: BoxContainer;
@export var creditsPanel: BoxContainer;

@export var controlButton: TextureButton
@export var settingsButton: TextureButton
@export var creditsButton: TextureButton
var lastButtonPressed: TextureButton;

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");

func _on_controls_pressed() -> void:
	lastButtonPressed = controlButton;
	controlsPanel.visible = true;
	get_node("PanelMenus/BoxContainer2/ControlsMenu").ReturnFirstButton().grab_focus();

func _on_settings_pressed() -> void:
	lastButtonPressed = settingsButton;
	settingsPanel.visible = true;
	get_node("PanelMenus/BoxContainer/SettingsMenu").ReturnFirstButton().grab_focus();

func _on_quit_pressed() -> void:
	get_tree().quit();

func _on_credits_pressed() -> void:
	lastButtonPressed = creditsButton;
	creditsPanel.visible = true;
	get_node("PanelMenus/BoxContainer3/CreditsMenu").ReturnFirstButton().grab_focus();

# When a panel closes, reget focus on the last button
func _on_close_panel() -> void:
	controlsPanel.visible = false;
	settingsPanel.visible = false;
	creditsPanel.visible = false;
	lastButtonPressed.grab_focus();
