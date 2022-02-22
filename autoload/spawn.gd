extends Node

func find_animation_tree(cur: Node) -> AnimationTree:
	var queue = [cur]
	while queue.size() > 0:
		var item = queue.pop_front()
		if item is AnimationTree:
			return item
		else:
			for k in item.get_children():
				queue.push_back(k)
	return null

func add_items(i, xform):
	get_viewport().add_child(i)
	i.global_transform = xform
var scenes = {}
func spawn_everything():
	var spawn = {}
	for k in get_tree().get_nodes_in_group("spawn"):
		var scene = k.get("scene")
		if scene:
			if !scenes.has(scene):
				scenes[scene] = load(scene)
			var scene_data = scenes[scene]
			if scene_data:
				var i = scene_data.instance()
				if i:
					call_deferred("add_items", i, k.global_transform)
					var anim_tree = find_animation_tree(i)
					assert(anim_tree)
					i.set_meta("animation_tree", anim_tree)
					var scripts = k.get("scripts")
					for d in scripts:
						var file_name = "res://scripts/modules/npc_" + d + ".gd"
						var s = load(file_name)
						if s:
							var script_node = s.new()
							i.add_child(script_node)
					k.queue_free()
				
var spawn_delay = 0.0
func _ready():
	return
	spawn_everything()
#	spawn_delay = 1.0

func _process(delta):
	if spawn_delay > 0.0:
		spawn_delay -= delta
	else:
		spawn_everything()
		spawn_delay = 1.0
