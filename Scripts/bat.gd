extends Area2D

var speed = 250
var initial_position: Vector2  # NUEVO: guarda la posición local original dentro de la pantalla

func _ready() -> void:  # NUEVO
	initial_position = position

func _physics_process(delta: float) -> void:
	position.x -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jew"):
		GameManager.jew_died()

func reset_bat() -> void:  # NUEVO: restaura posición al reutilizarse desde el pool
	position = initial_position
