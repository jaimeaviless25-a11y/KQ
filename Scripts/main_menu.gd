extends CanvasLayer

@onready var record_label = $"Coin Record"
@onready var best_time_label = $BestTimeLabel

func _ready() -> void:
	visible = true
	get_tree().paused = true
	record_label.text = "Récord: " + str(SaveManager.best_score)
	best_time_label.text = "Best Time: " + SaveManager.format_time(SaveManager.best_time)

func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().get_first_node_in_group("game_manager").start_game()
