class_name ScoreSave extends Resource

@export var high_score : int = 0

const SAVE_PATH : String = "user://EiffelAxisScoreSave.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static func load_or_create() -> ScoreSave:
	var res:ScoreSave
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as ScoreSave
	else:
		res = ScoreSave.new()
	return res
