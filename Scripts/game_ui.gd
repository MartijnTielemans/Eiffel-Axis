extends Control

var health : int
var health_icons = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_icons.append($HBoxContainer/Heart1)
	health_icons.append($HBoxContainer/Heart2)
	health_icons.append($HBoxContainer/Heart3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_visuals():
	for i in 3:
		if i < health:
			print(health_icons[i])
			var full_heart = load("res://Assets/UI/UI_Heart_Full.png")
			health_icons[i].texture = full_heart
		else:
			var empty_heart = load("res://Assets/UI/UI_Heart_Empty.png")
			health_icons[i].texture = empty_heart
