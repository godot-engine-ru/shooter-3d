extends Node


func _ready():

	navigation = find_navigation(get_viewport())
	if navigation:
		use_navugation = true
	state = 1

	npc = get_parent()
	anim = npc.get_meta("animation_tree")
	assert(npc)
	assert(anim)

	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout", [timer])
#	timer.wait_time = rand_range(0.3, 15)
	timer.wait_time = 0.5
	timer.start()
	
	player_ = get_tree().get_nodes_in_group("player")[0]

	speed = rand_range(2,7)

var state = 0
var navigation: Navigation
var use_navugation = false
var npc: KinematicBody
var anim: AnimationTree

var player_


export var speed = 5

var path = []
var path_index = 0


func _on_Timer_timeout(timer:Timer):
	if not is_instance_valid(navigation): return
#	timer.wait_time = rand_range(0.3, 15)

#	может пригодится
#	var closest_point:Vector3 = navigation.get_closest_point(player_.global_transform.origin)

	
	if not Debug.stop_navigation:

		path = navigation.get_simple_path(npc.global_transform.origin, player_.global_transform.origin)

		if not path: # нужно ли
			return
		path_index = 0


var dir:=Vector3.ZERO




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
#			lookat.y = npc.global_transform.origin.y
			var distance = xform.origin.distance_squared_to(lookat)
			if distance > 8.0:
				if use_navugation:
					state = 200
				else:
					xform = xform.looking_at(lookat, Vector3.UP)
					npc.global_transform = xform
					anim["parameters/state/playback"].travel("run")
		200:
#			print("implement using navigation")

			if path_index <path.size():
				var direction = path[path_index] - npc.global_transform.origin
				if direction.length()<1:
					path_index+=1
				else:
					
					npc.move_and_slide(direction.normalized()*speed)


					# поворот тела npc:

					var a = Quat(npc.transform.basis)
					var po = path[path_index]
					po.y = npc.transform.origin.y
					var b = Quat(npc.transform.looking_at(po, Vector3.UP).basis)
					var c = a.slerp(b, 0.08)
					npc.transform.basis = Basis(c)

					anim["parameters/state/playback"].travel("run")
			else:
				anim["parameters/state/playback"].travel("idle")
