extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = get_viewport().gui_get_focus_owner().global_position.y
