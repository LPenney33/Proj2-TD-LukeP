extends Camera2D

@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var camera_speed: float = 1000.0

func _process(_delta):
	if Input.is_action_pressed("zoom_out"):
		zoom_camera(true)
	elif Input.is_action_pressed("zoom_in"):
		zoom_camera(false)

	# Add these lines for camera movement
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_camera_up"):
		movement.y -= camera_speed * _delta
	if Input.is_action_pressed("move_camera_down"):
		movement.y += camera_speed * _delta
	if Input.is_action_pressed("move_camera_left"):
		movement.x -= camera_speed * _delta
	if Input.is_action_pressed("move_camera_right"):
		movement.x += camera_speed * _delta

	position += movement

	var new_position = position + movement
	new_position.x = clamp(new_position.x, limit_left, limit_right)
	new_position.y = clamp(new_position.y, limit_top, limit_bottom)
	position = new_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_camera(true)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_camera(false)

func zoom_camera(zoom_out: bool):
	var zoom_change = -zoom_speed if zoom_out else zoom_speed
	zoom = Vector2(clamp(zoom.x + zoom_change, min_zoom, max_zoom), clamp(zoom.y + zoom_change, min_zoom, max_zoom))
