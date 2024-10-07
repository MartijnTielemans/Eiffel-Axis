extends Area2D

@onready var myparent = get_parent()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player_Bullet:
		body.destroy_self()
	else:
		body.queue_free()
