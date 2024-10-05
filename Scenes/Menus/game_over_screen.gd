extends Control

@export var playerScoreNumber : Label
@export var highScoreNumber : Label
@export var rankImage : TextureRect

@export var rankImages : Array[CompressedTexture2D]
@export var rankThresholds : Array[int]

var canPress : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerScoreNumber.text = str(Global.latest_score)
	highScoreNumber.text = str(Global.score_save.high_score)
	
	var index = GetCorrectRank(Global.latest_score)
	rankImage.texture = rankImages[index]


# Returns an int correspond to the rank level received
func GetCorrectRank(score: int) -> int:
	var rankIndex : int = 0
	for i in rankThresholds:
		if score > i:
			rankIndex += 1
	
	return rankIndex


func _input(event: InputEvent) -> void:
	if !canPress:
		return
	
	if event is InputEventKey or event is InputEventJoypadButton:
		SceneTransition.transitionOver.connect(LoadScene);
		SceneTransition.Transition(true);


func LoadScene():
	SceneTransition.Transition(false);
	get_tree().change_scene_to_file("res://Scenes/Menus/MenuMain.tscn");


func _on_can_continue_timer_timeout() -> void:
	canPress = true
