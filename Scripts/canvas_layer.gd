extends CanvasLayer

@onready var jump_button = $JumpButton  # ajusta la ruta si es distinta
@onready var down_button = $DownButton  # ajusta la ruta si es distinta

const MARGIN_RIGHT = 250  # distancia desde el borde derecho
const MARGIN_BOTTOM = 100  # distancia del botón de abajo respecto al borde inferior
const BUTTON_GAP = 85  # espacio vertical entre ambos botones

func _ready() -> void:
	position_buttons()
	get_viewport().size_changed.connect(position_buttons)  # se reajusta si cambia la resolución

func position_buttons() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	down_button.position = Vector2(
		screen_size.x - MARGIN_RIGHT,
		screen_size.y - MARGIN_BOTTOM
	)
	jump_button.position = Vector2(
		screen_size.x - MARGIN_RIGHT,
		screen_size.y - MARGIN_BOTTOM - BUTTON_GAP
	)
