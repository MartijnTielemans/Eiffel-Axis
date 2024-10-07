extends Control

var finalScore : int
var highScore : int
var currentScoreLerp : int = 0
var canCountScore : bool = true

@export var playerScoreNumber : Label
@export var highScoreNumber : Label
@export var rankImage : TextureRect
@export var bigText : TextureRect
@export var winText : CompressedTexture2D

@export var rankImages : Array[CompressedTexture2D]
@export var rankThresholds : Array[int]

var canPress : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_won:
		bigText.texture = winText
	
	finalScore = Global.latest_score
	highScore = Global.score_save.high_score
	
	var index = GetCorrectRank(Global.latest_score)
	rankImage.texture = rankImages[index]


func _process(delta: float) -> void:
	if canCountScore:
		var currentNumber = lerp(currentScoreLerp, finalScore, 0.25 * delta)
		playerScoreNumber.text = str(snapped(currentNumber, 0))
		var highNumber = lerp(currentScoreLerp, highScore, 0.28 * delta)
		highScoreNumber.text = str(snapped(highNumber, 0))
		currentScoreLerp = currentNumber


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


func _on_score_counter_lock_timer_timeout() -> void:
	canCountScore = false
	playerScoreNumber.text = str(finalScore)
	highScoreNumber.text = str(Global.score_save.high_score)
