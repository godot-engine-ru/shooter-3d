extends Spatial

const player_scene = preload("res://player/player.tscn")
const portal_scene = preload("res://level/portal_room/portal.tscn")
const scene_path = "res://level"


var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const WIDTH = 50
const DEPTH = 50
const PORTAL_RADIUS = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var bbox = Rect2(-WIDTH / 2.0, - DEPTH / 2.0, WIDTH, DEPTH)
	var floor_mi = MeshInstance.new()
	var floor_mesh: = PlaneMesh.new()
	floor_mesh.size.x = WIDTH
	floor_mesh.size.y = DEPTH
	floor_mi.mesh = floor_mesh
	add_child(floor_mi)
	var c0 = CollisionShape.new()
	var c1 = CollisionShape.new()
	var c2 = CollisionShape.new()
	var c3 = CollisionShape.new()
	var c4 = CollisionShape.new()

	var sh0: = BoxShape.new()
	sh0.extents.x = WIDTH / 2.0
	sh0.extents.z = DEPTH / 2.0
	sh0.extents.y = 1.0
	c0.shape = sh0
	
	var sh1: = BoxShape.new()
	sh1.extents.x = WIDTH / 2.0
	sh1.extents.z = 1.0
	sh1.extents.y = 10.0
	c1.shape = sh1
	c2.shape = sh1
	var sh2: = BoxShape.new()
	sh2.extents.x = 1.0
	sh2.extents.z = DEPTH / 2.0
	sh2.extents.y = 10.0
	c3.shape = sh2
	c4.shape = sh2

	$StaticBody.add_child(c0)
	c0.transform = Transform(Basis(), Vector3(0, -1, 0))
	$StaticBody.add_child(c1)
	c1.transform = Transform(Basis(), Vector3(0, 10, DEPTH / 2))
	$StaticBody.add_child(c2)
	c2.transform = Transform(Basis(), Vector3(0, 10, -DEPTH / 2))
	$StaticBody.add_child(c3)
	c3.transform = Transform(Basis(), Vector3(WIDTH / 2.0, 10, 0))
	$StaticBody.add_child(c4)
	c4.transform = Transform(Basis(), Vector3(-WIDTH / 2.0, 10, 0))

	var scene_dir = Directory.new()
	var r = scene_dir.open(scene_path)
	assert(r == OK)
	scene_dir.list_dir_begin()
	var path = scene_dir.get_next()
	var portal_paths = []
	while path != "":
		print(path)
		if path.ends_with(".tscn"):
			if path.begins_with("level"):
				portal_paths.push_back(scene_path + "/" + path)
			if path.begins_with("test_level"):
				portal_paths.push_back(scene_path + "/" + path)
		path = scene_dir.get_next()
	print(portal_paths)
	var radius_step = 5.0
	var angle_step = 0.0
	var id = 0
	while portal_paths.size() > 0:
		var portal_path = portal_paths.pop_front()
		var circ = radius_step * 2.0 * PI
		var posx = cos(angle_step) * radius_step
		var posz = sin(angle_step) * radius_step
		var xform = Transform(Basis().rotated(Vector3.UP, angle_step), Vector3(posx, 0, posz))
		var portal = portal_scene.instance()
		portal.set_meta("scene", portal_path)
		portal.set_meta("portal_id", id)
		add_child(portal)
		portal.transform = xform
		var angle_inc = 2.0 * PI * PORTAL_RADIUS / circ
		angle_step += angle_inc
		if angle_step > 2.0 * PI - PORTAL_RADIUS:
			angle_step = 0
			radius_step += PORTAL_RADIUS

	player = player_scene.instance()
	add_child(player)
	player.transform = Transform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
