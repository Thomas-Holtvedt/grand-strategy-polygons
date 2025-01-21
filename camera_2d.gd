extends Camera2D

#Camera zoom
var camera_zoom_direction: float = 0.0
@export var camera_zoom_speed:float = 2.0
@export var camera_zoom_min:float = 15.0
@export var camera_zoom_max:float = 4.0

# Camera move
@export var camera_move_speed:float = 400.0

#Camera pan
@export var camera_pan_margin:int = 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_zoom(delta)
	camera_move(delta)
	camera_pan(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("camera_zoom_in"):
		camera_zoom_direction = 1
	elif event.is_action("camera_zoom_out"):
		camera_zoom_direction = -1

func camera_zoom(delta:float)-> void:
	var new_zoom : float = clamp(zoom.x + (camera_zoom_speed * zoom.x) * camera_zoom_direction * delta, camera_zoom_max,camera_zoom_min)
	zoom = Vector2(new_zoom,new_zoom)
	camera_zoom_direction *= 0.9
	
func camera_move(delta:float)-> void:
	var velocity_direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("camera_forward"): velocity_direction.y -= 1
	if Input.is_action_pressed("camera_backward"): velocity_direction.y += 1
	if Input.is_action_pressed("camera_right"): velocity_direction.x += 1
	if Input.is_action_pressed("camera_left"): velocity_direction.x -= 1
	
	position += velocity_direction.normalized() * (camera_move_speed / zoom.x) * delta

func camera_pan(delta:float)-> void:
	var viewport_current: Viewport = get_viewport()
	var pan_direction: Vector2 = Vector2(-1,-1)
	var viewport_visible_rectangle: Rect2 = Rect2(viewport_current.get_visible_rect())
	var viewport_size: Vector2 = viewport_visible_rectangle.size
	var current_mouse_position: Vector2 = viewport_current.get_mouse_position()
	
	# X axis
	if (current_mouse_position.x < camera_pan_margin) or (current_mouse_position.x > viewport_size.x - camera_pan_margin):
		if ( current_mouse_position.x > viewport_size.x/2.0):
			pan_direction.x = 1
		position.x += pan_direction.x * (camera_move_speed / zoom.x) * delta
	
	# Y axis
	if (current_mouse_position.y < camera_pan_margin) or (current_mouse_position.y > viewport_size.y - camera_pan_margin):
		if ( current_mouse_position.y > viewport_size.y/2.0):
			pan_direction.y = 1
		position.y += pan_direction.y * (camera_move_speed / zoom.x) * delta
