extends Node


func _ready():
	npc = get_parent()
	anim = npc.get_meta("animation_tree")
	assert(npc)
	assert(anim)

var state = 0
var navigation: Navigation
var use_navugation = false
var npc: KinematicBody
var anim: AnimationTree
func find_navigation(n: Node) -> Navigation:
	var queue = [n]
	while queue.size() > 0:
		var item = queue.pop_front()
		if item is Navigation:
			return item
		for k in item.get_children():
			queue.push_back(k)
	return null
func _physics_process(delta):
	var cam = get_viewport().get_camera()
	if !cam:
		return
	assert(cam.has_meta("player"))
	var player = cam.get_meta("player")
	if !player:
		return
	match state:
		0:
			navigation = find_navigation(get_viewport())
			if navigation:
				use_navugation = true
			state = 1
		1:
			var xform: Transform = npc.global_transform
			var lookat = player.global_transform.origin
			lookat.y = npc.global_transform.origin.y
			var distance = xform.origin.distance_squared_to(lookat)
			if distance > 8.0:
				if use_navugation:
					state = 200
				else:
					xform = xform.looking_at(lookat, Vector3.UP)
					npc.global_transform = xform
					anim["parameters/state/playback"].travel("run")
		200:
			print("implement using navigation")
