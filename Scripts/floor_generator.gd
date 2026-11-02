extends Node

@export var screens: Array[PackedScene]
@export var instances_per_type: int = 2  # NUEVO: copias de CADA tipo a pre-crear; sube si el pool se queda corto

@onready var marker: Marker2D = $Marker2D

var pool: Array[Node] = []  # NUEVO

func _ready() -> void:  # NUEVO: pre-crea el pool completo, con variedad garantizada
	for screen_type in screens:
		for i in instances_per_type:
			var instance: Node = screen_type.instantiate()
			instance.visible = false
			instance.process_mode = Node.PROCESS_MODE_DISABLED
			add_child(instance)
			instance.expired.connect(deactivate_screen.bind(instance))
			pool.append(instance)

func _on_timer_timeout() -> void:
	var screen_instance = get_pooled_screen()
	if screen_instance == null:
		return  # no hay ninguna libre ahora mismo; sube instances_per_type si pasa seguido
	screen_instance.position = marker.position
	screen_instance.visible = true
	screen_instance.process_mode = Node.PROCESS_MODE_INHERIT
	screen_instance.reset()

func get_pooled_screen() -> Node:  # NUEVO
	var available: Array[Node] = []
	for screen in pool:
		if not screen.visible:
			available.append(screen)
	if available.is_empty():
		return null
	return available.pick_random()  # elige al azar entre las libres, para mantener variedad real

func deactivate_screen(screen_instance: Node) -> void:  # NUEVO
	screen_instance.visible = false
	screen_instance.process_mode = Node.PROCESS_MODE_DISABLED
