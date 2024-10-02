extends Control

@onready var spawner_ref = $"../Wave_spawner"
var health : int
var health_icons = []
var progress : float = 0
var max_progress : float = 1
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_icons.append($HBoxContainer/Heart1)
	health_icons.append($HBoxContainer/Heart2)
	health_icons.append($HBoxContainer/Heart3)
	max_progress = int(len(spawner_ref.waves))-1
	

func update_visuals():
	for i in 3:
		if i < health:
			print(health_icons[i])
			var full_heart = load("res://Assets/UI/UI_Heart_Full.png")
			health_icons[i].texture = full_heart
		else:
			var empty_heart = load("res://Assets/UI/UI_Heart_Empty.png")
			health_icons[i].texture = empty_heart

func update_points():
	$Label.text = str(points)

func update_progress():
	$BarCells.region_rect = Rect2(0,0,progress*144,7)
	var x = 84+((progress*144)*0.5)
	$BarCells.position = Vector2(x,7)
