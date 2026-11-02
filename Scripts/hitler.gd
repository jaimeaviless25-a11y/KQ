extends Area2D

signal expired

var speed = 500
const LIFETIME = 3.0

func _physics_process(delta: float) -> void:
	if visible:
		position.x -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jew"):
		GameManager.jew_died()

func activate(spawn_position: Vector2) -> void:
	position = spawn_position
	visible = true
	monitoring = true
	get_tree().create_timer(LIFETIME).timeout.connect(deactivate)

func deactivate() -> void:
	visible = false
	monitoring = false
	expired.emit()
