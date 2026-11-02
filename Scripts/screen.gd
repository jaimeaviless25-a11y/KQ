extends StaticBody2D

signal expired  # NUEVO: avisa al generador que debe desactivarse, en vez de destruirse

var speed = 300

func _physics_process(delta: float) -> void:
	position.x -= speed * delta

func _on_timer_timeout() -> void:
	expired.emit()  # MODIFICADO: antes hacía queue_free(), ahora solo avisa

func reset() -> void:
	$Timer.start()
	reset_children_recursive(self)  # MODIFICADO: ahora busca en todos los niveles, no solo hijos directos

func reset_children_recursive(node: Node) -> void:  # NUEVO
	for child in node.get_children():
		if child.has_method("reset_coin"):
			child.reset_coin()
		elif child.has_method("reset_bat"):
			child.reset_bat()
		elif child.has_method("reset_sign"):
			child.reset_sign()
		reset_children_recursive(child)
