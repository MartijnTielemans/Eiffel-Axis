extends Control

@export var firstButton: TextureButton;
signal closePanel;

func ReturnFirstButton() -> TextureButton:
	return firstButton;

# Emit the close panel signal
func _on_texture_button_pressed() -> void:
	closePanel.emit();
