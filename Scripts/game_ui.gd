extends Control

@onready var spawner_ref = $"../Wave_spawner"
var health : int = 3
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
	# Get player and subscribe to death signal
	var player_character: Player = $"../PlayerCharacter"
	player_character.on_death.connect(_game_over)

func update_visuals():
	for i in 3:
		if i < health:
			var full_heart = load("res://Assets/UI/UI_Heart_Full.png")
			health_icons[i].texture = full_heart
		else:
			var empty_heart = load("res://Assets/UI/UI_Heart_Empty.png")
			health_icons[i].texture = empty_heart


func update_points(extra_points: int):
	points += extra_points
	$Label.text = str(points)

func update_progress():
	$BarCells.region_rect = Rect2(0,0,progress*144,7)
	var x = 84+((progress*144)*0.5)
	$BarCells.position = Vector2(x,7)

func _game_over():
	Global.save_score(points)
	print("saving points")
