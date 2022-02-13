tool
extends Spatial

func _ready():
	pass

var spawn_scene = ""
var scripts = []

const sd_path = "res://npc"

func _get_property_list() -> Array:
	var props = []
	var scenes = []
	var dir: = Directory.new()
	if dir.open(sd_path) == OK:
		var result = dir.list_dir_begin()
		assert(result == OK)
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("npc_"):
				if dir.current_is_dir():
					var scene_path = sd_path + "/" + file_name + "/npc.tscn"
					var fd : = File.new()
					if fd.file_exists(scene_path):
						scenes.push_back(scene_path)
				elif file_name.ends_with(".tscn"):
					var scene_path = sd_path + "/" + file_name + ".tscn"
					scenes.push_back(scene_path)
			file_name = dir.get_next()
	props.push_back(
		{
			"name": "scene",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "," + ",".join(scenes),
			"usage": PROPERTY_USAGE_DEFAULT
		}
	)
	props.push_back(
		{
			"name": "scripts",
			"type": TYPE_ARRAY,
			"hint": PROPERTY_HINT_NONE,
			"hint_string": "",
			"usage": PROPERTY_USAGE_DEFAULT
		}
	)
	return props
func _get(property):
	match property:
		"scene":
			return spawn_scene
		"scripts":
			return scripts
	return null
func _set(property, value):
	match property:
		"scene":
			spawn_scene = value
		"scripts":
			scripts = value
