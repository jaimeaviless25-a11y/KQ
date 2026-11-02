extends Control

@onready var icon = $Sprite2D  # ajusta la ruta a tu nodo

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(icon, "rotation", TAU, 2.0).from(0.0)  # una vuelta completa cada 1.5s

	await get_tree().create_timer(2.0).timeout  # NUEVO: cuánto tiempo se muestra la pantalla
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")  # ajusta a la ruta de tu escena principal
