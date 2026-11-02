extends Node

var best_score = 0
var best_time = 0.0
const SAVE_PATH = "user://savegame.save"

func _ready() -> void:
	load_data()

func check_and_save_best_score(score: int) -> void:
	if score > best_score:
		best_score = score
		save_data()

func check_and_save_best_time(time: float) -> void:
	if time > best_time:
		best_time = time
		save_data()

func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {"best_score": best_score, "best_time": best_time}
	file.store_var(data)
	file.close()

func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = file.get_var()
		file.close()
		if data is Dictionary:
			best_score = data.get("best_score", 0)
			best_time = data.get("best_time", 0.0)
		else:
			best_score = 0
			best_time = 0.0
	else:
		best_score = 0
		best_time = 0.0

func format_time(seconds: float) -> String:
	var minutes = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [minutes, secs]
