extends Node2D

@export var pool_size: int = 10

var hitler = preload("res://Scenes/hitler.tscn")
var spawn_points := []
var pool: Array[Node] = []

@onready var sound = $AudioStreamPlayer2D

var active_sounds = 0  # NUEVO: cuenta cuántos "3 segundos" están pendientes de terminar

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
	for i in pool_size:
		var instance = hitler.instantiate()
		instance.visible = false
		instance.monitoring = false
		add_child(instance)
		pool.append(instance)

func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var hitler_instance = get_pooled_hitler()
	if hitler_instance == null:
		return
	hitler_instance.activate(spawn.position)
	play_spawn_sound()  # NUEVO

func play_spawn_sound() -> void:  # NUEVO
	active_sounds += 1
	if not sound.playing:
		sound.play()
	get_tree().create_timer(2.5).timeout.connect(on_sound_timer_done)

func on_sound_timer_done() -> void:  # NUEVO
	active_sounds -= 1
	if active_sounds <= 0:
		sound.stop()
		active_sounds = 0  # por seguridad, evita números negativos

func get_pooled_hitler() -> Node:
	for h in pool:
		if not h.visible:
			return h
	return null
