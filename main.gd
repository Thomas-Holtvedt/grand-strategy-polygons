extends Node2D

var file_path = "res://provinces-nodes.txt"
var province_scene = preload("res://Province.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var polygons = {}
	
	while not file.eof_reached():
		var line = file.get_line()
		var parts = line.split(",")
		var shapeid = 0
		var partid = 0
		if parts.size() < 4:
			continue
		shapeid = parts[0].to_int()
		partid = parts[1].to_int()
		var x = parts[2].to_float()
		var y = parts[3].to_float()
		
		if not polygons.has(shapeid):
			polygons[shapeid] = []
		while polygons[shapeid].size() <= partid:
			polygons[shapeid].append([])
		polygons[shapeid][partid].append(Vector2(x, -y))
	
	for shapeid in polygons.keys():
		create_shape(shapeid, polygons[shapeid])

func create_shape(shapeid, parts):
	var shape_area = province_scene.instantiate()
	shape_area.name = str(shapeid)
	add_child(shape_area)
	
	for partid in range(parts.size()):
		var polygon_points = parts[partid]
		create_part(shape_area, partid, polygon_points)

func create_part(parent_node, partid, points):
	var unique_points = points.duplicate()
	
	var polygon = Polygon2D.new()
	polygon.polygon = unique_points
	polygon.name = str(partid)
	
	var collision_polygon = CollisionPolygon2D.new()
	collision_polygon.polygon = unique_points
	collision_polygon.name = str(partid)
	
	parent_node.add_child(polygon)
	parent_node.add_child(collision_polygon)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
