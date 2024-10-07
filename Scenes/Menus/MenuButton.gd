extends TextureButton

@export var isFirst = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (isFirst):
		GrabFocus();

func GrabFocus() -> void:
	grab_focus();
