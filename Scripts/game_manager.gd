extends Control

var score = 0
var elapsed_time = 0.0
var timing = false
var is_dead = false

@onready var sprite=$CanvasLayer/Sprite2D
@onready var label=$CanvasLayer/CoinLabel
@onready var death=$JewDied
@onready var sound=$JewDied/AudioStreamPlayer2D
@onready var timer_label = $CanvasLayer/TimerLabel

func _ready() -> void:
	add_to_group("game_manager")
	hide_score()
	sound.finished.connect(_on_sound_finished)

func _process(delta: float) -> void:
	if timing:
		elapsed_time += delta
		timer_label.text = SaveManager.format_time(elapsed_time)

func start_game():
	elapsed_time = 0.0
	timing = true
	show_score()

func add_score(amount: int = 1) -> void:
	score += amount
	$CanvasLayer/CoinLabel.text = "" + str(score)

func reset_score():
	score = 0
	elapsed_time = 0.0
	hide_score()

func show_score():
	sprite.visible=true
	label.visible=true
	timer_label.visible=true

func hide_score():
	sprite.visible=false
	label.visible=false
	timer_label.visible=false

func jew_died():
	if is_dead:
		return
	is_dead = true
	timing = false
	get_tree().paused = true
	death.visible = true
	sound.play()

func _on_sound_finished():
	is_dead = false
	SaveManager.check_and_save_best_score(score)
	SaveManager.check_and_save_best_time(elapsed_time)
	reset_score()
	death.visible = false
	get_tree().reload_current_scene()
