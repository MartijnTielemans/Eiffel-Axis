extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if not area is enemy_bullet:
		if area.global_position.x < 300 and not area.myparent.start_left:
			area.myparent.lose_points()
			area.myparent.die()
			print("FUCK")
		elif area.global_position.x > 20 and area.myparent.start_left:
			area.myparent.lose_points()
			area.myparent.die()
			print("FUck")
