extends Camera2D

@export var zoom_step_size: float = 0.1

func _ready():
	pass

func _process(delta):
	pass

func _unhandled_input(event):
	var zoom_pos: Vector2 = Vector2(0, 0)
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_pos = get_global_mouse_position()
				self.zoom = Vector2(self.zoom.x * (1 + zoom_step_size), self.zoom.y * (1 + zoom_step_size))
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_pos = get_global_mouse_position()
				self.zoom = Vector2(self.zoom.x * (1 - zoom_step_size), self.zoom.y * (1 - zoom_step_size))
