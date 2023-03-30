extends Camera2D

@export var zoom_step_size: float = 0.1

# Variables for calculating mouse dragging
var is_dragging = false
var drag_from_pos: Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	pass

func _unhandled_input(event):
	handle_zoom(event)
	handle_dragging(event)

func handle_zoom(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_in(get_global_mouse_position())
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out(get_global_mouse_position())

func handle_dragging(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_dragging = true
			drag_from_pos = get_global_mouse_position()
		else:
			is_dragging = false
	if event is InputEventMouseMotion and is_dragging:
		position = drag_from_pos - get_local_mouse_position()

func zoom_in(zoom_pos):
	self.zoom = Vector2(self.zoom.x * (1 + zoom_step_size), self.zoom.y * (1 + zoom_step_size))

func zoom_out(zoom_pos):
	self.zoom = Vector2(self.zoom.x * (1 - zoom_step_size), self.zoom.y * (1 - zoom_step_size))
