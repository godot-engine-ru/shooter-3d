extends Node

export(NodePath) var target_path

export(float) var follow_speed = 10

var target:Spatial

onready var parent = get_parent()

func _ready():
	parent.set_as_toplevel(true)

	if not target_path: return
	target = get_node_or_null(target_path)
	if not target: return



func _physics_process(delta):
	if follow_speed:
		parent.global_transform = parent.global_transform.interpolate_with(target.global_transform, delta * follow_speed)
	else:
		return
		var offset = Vector3(target.h_offset,0, target.v_offset)
		parent.global_transform = target.global_transform.translated(offset)
