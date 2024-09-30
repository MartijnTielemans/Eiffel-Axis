extends CanvasLayer

signal transitionOver;

func Transition(fadeIn):
	if (fadeIn):
		$AnimationPlayer.play("Fade_In")
	else:
		$AnimationPlayer.play("Fade_Out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Fade_In"):
		emit_signal(("transitionOver"));
