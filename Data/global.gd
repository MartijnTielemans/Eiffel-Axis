extends Node

var latest_score : int
var score_save : ScoreSave
var player_won : bool = false

func load_score():
	score_save = ScoreSave.load_or_create()


func save_score(score:int):
	latest_score = score
	if (latest_score > score_save.high_score):
		score_save.high_score = latest_score
		score_save.save()
	
