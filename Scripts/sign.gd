extends Node2D

@export var textures: Array[Texture2D] = []
@export var target_width: float = 100.0

@onready var sprite = $Sprite2D

func _ready() -> void:
	reset_sign()  # MODIFICADO: la lógica se movió a una función reutilizable

func reset_sign() -> void:  # NUEVO: separado de _ready() para poder llamarlo de nuevo al reutilizar el nodo
	if textures.is_empty():
		push_warning("Sign: no hay texturas asignadas en el array 'textures'")
		return
	var chosen = textures[randi() % textures.size()]
	sprite.texture = chosen
	scale_to_target_width(chosen)

func scale_to_target_width(texture: Texture2D) -> void:
	var original_width = texture.get_width()
	var scale_factor = target_width / original_width
	sprite.scale = Vector2(scale_factor, scale_factor)
