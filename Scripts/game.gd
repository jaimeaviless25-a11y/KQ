extends Node2D

var spawner = preload("res://Scenes/hitler_spawner.tscn")

func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	var spawner_instance = spawner.instantiate()
	call_deferred("add_child", spawner_instance)
	spawner_instance.position = $SpawnSpawner.position
