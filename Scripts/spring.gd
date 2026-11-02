extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Jew"):
		body.velocity.y = -1500
