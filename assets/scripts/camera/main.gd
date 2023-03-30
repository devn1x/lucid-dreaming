extends Camera2D

@export var zoom_step_size: float = 0.1
@export var keyboard_move_speed: float = 7

# Variables for calculating camera movement via mouse
var is_dragging: bool = false
var drag_from_pos: Vector2 = Vector2.ZERO

# Variables for calculating camera movement via keyboard
var keyboard_move_direction: Vector2 = Vector2.ZERO
var keyboard_move_state_up: bool = false
var keyboard_move_state_down: bool = false
var keyboard_move_state_left: bool = false
var keyboard_move_state_right: bool = false

func _ready():
	position_smoothing_enabled = false

func _process(delta: float):
	# TODO: Bring delta into this, so movement is independent of framerate
	position += (keyboard_move_direction * keyboard_move_speed) / zoom.x

func _unhandled_input(event: InputEvent):
	handle_zoom(event)
	handle_movement_mouse(event)
	handle_movement_keyboard(event)

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

func handle_movement_keyboard(event: InputEvent):
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				keyboard_move_state_up = event.is_pressed()
			KEY_S:
				keyboard_move_state_down = event.is_pressed()
			KEY_A:
				keyboard_move_state_left = event.is_pressed()
			KEY_D:
				keyboard_move_state_right = event.is_pressed()
	
	keyboard_move_direction = Vector2.ZERO
	if keyboard_move_state_up and not keyboard_move_state_down:
		keyboard_move_direction.y = -1
	if keyboard_move_state_down and not keyboard_move_state_up:
		keyboard_move_direction.y = 1
	if keyboard_move_state_left and not keyboard_move_state_right:
		keyboard_move_direction.x = -1
	if keyboard_move_state_right and not keyboard_move_state_left:
		keyboard_move_direction.x = 1
	keyboard_move_direction = keyboard_move_direction.normalized()

func zoom_in(zoom_pos: Vector2):
	self.zoom = Vector2(self.zoom.x * (1 + zoom_step_size), self.zoom.y * (1 + zoom_step_size))

func zoom_out(zoom_pos: Vector2):
	self.zoom = Vector2(self.zoom.x * (1 - zoom_step_size), self.zoom.y * (1 - zoom_step_size))
