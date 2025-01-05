extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		for node in get_parent().get_children():
			if node is Area2D:
				for subnode in node.get_children():
					if subnode is Polygon2D:
						subnode.modulate = Color(1,1,1,0)
		for subnode in self.get_children():
			if subnode is Polygon2D:
				subnode.modulate = Color(1,0,0,0.7)
