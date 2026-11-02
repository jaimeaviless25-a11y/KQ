extends CharacterBody2D

const JUMP_VELOCITY = -900.0
const gravity = 2500

@onready var collision = $CollisionShape2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if velocity.y < 1000:
		velocity += (get_gravity() * delta) * 2
	
	if Input.is_action_just_released("ui_up") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_down"):
		velocity.y = gravity

	move_and_slide()
