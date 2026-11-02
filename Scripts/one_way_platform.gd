extends StaticBody2D

@onready var collision = $CollisionShape2D
@onready var area = $Area2D
@onready var timer = $Timer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		collision.set_deferred("disabled", true)
		area.set_deferred("monitoring", true)
		timer.start()

func _on_timer_timeout() -> void:
	collision.set_deferred("disabled", false)
	area.set_deferred("monitoring", false)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jew"):
		body.velocity.y = 1000
