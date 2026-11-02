extends Area2D

@onready var animated_sprite=$AnimatedSprite2D
@onready var collision=$CollisionShape2D
@onready var pickup_sound=$AudioStreamPlayer2D
@onready var special_sprite = $SpecialSprite

const SPECIAL_CHANCE = 0.05
const SPECIAL_VALUE = 5
const NORMAL_VALUE = 1

var value = NORMAL_VALUE
var tween: Tween

func _ready() -> void:
	special_sprite.visible = false
	if randf() < SPECIAL_CHANCE:
		value = SPECIAL_VALUE
		animated_sprite.visible = false
		special_sprite.visible = true
		start_float_tween()

func start_float_tween() -> void:
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(special_sprite, "position:y", special_sprite.position.y - 2.5, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(special_sprite, "position:y", special_sprite.position.y + 2.5, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_body_entered(body):
	if body.is_in_group("Jew"):
		collision.set_deferred("disabled", true)
		animated_sprite.visible=false
		special_sprite.visible=false
		GameManager.add_score(value)
		GameManager.show_score()
		pickup_sound.play()
		pickup_sound.finished.connect(_on_sound_finished)

func _on_sound_finished():
	pickup_sound.finished.disconnect(_on_sound_finished)  # NUEVO: evita conexiones duplicadas al reutilizarse, mismo problema que tuvimos en Game Manager
	# MODIFICADO: se quitó queue_free() — la moneda ya no se destruye, solo queda oculta/sin colisión hasta que reset_coin() la reactive

func reset_coin() -> void:
	if tween:
		tween.kill()
	collision.set_deferred("disabled", false)
	animated_sprite.visible = true
	special_sprite.visible = false
	value = NORMAL_VALUE
	if randf() < SPECIAL_CHANCE:
		value = SPECIAL_VALUE
		animated_sprite.visible = false
		special_sprite.visible = true
		start_float_tween()
