extends Camera2D

@export_category("Control Parameters")
## Size of a single zoom step
@export var zoom_step_size: float = 0.1
## Camera speed in pixels per second
@export var keyboard_move_speed: float = 100

# Variables for calculating camera movement via mouse
var is_dragging: bool = false
var drag_from_pos: Vector2 = Vector2.ZERO

func _ready():
	position_smoothing_enabled = false

func _process(delta: float):
	process_movement_keyboard(delta)

func _unhandled_input(event: InputEvent):
	handle_zoom(event)
	handle_movement_mouse(event)

func handle_zoom(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_in(get_global_mouse_position())
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out(get_global_mouse_position())

func handle_movement_mouse(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_dragging = true
			drag_from_pos = get_global_mouse_position()
		else:
			is_dragging = false
	if event is InputEventMouseMotion and is_dragging:
		position = drag_from_pos - get_local_mouse_position()

func process_movement_keyboard(delta: float):
	if Input.is_action_pressed("camera_left"):
		global_position += Vector2.LEFT * delta * keyboard_move_speed / zoom.x
	if Input.is_action_pressed("camera_right"):
		global_position += Vector2.RIGHT * delta * keyboard_move_speed / zoom.x
	if Input.is_action_pressed("camera_up"):
		global_position += Vector2.UP * delta * keyboard_move_speed / zoom.x
	if Input.is_action_pressed("camera_down"):
		global_position += Vector2.DOWN * delta * keyboard_move_speed / zoom.x

func zoom_in(_zoom_pos: Vector2):
	self.zoom = Vector2(self.zoom.x * (1 + zoom_step_size), self.zoom.y * (1 + zoom_step_size))

func zoom_out(_zoom_pos: Vector2):
	self.zoom = Vector2(self.zoom.x * (1 - zoom_step_size), self.zoom.y * (1 - zoom_step_size))
