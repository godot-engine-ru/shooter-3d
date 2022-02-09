extends Node

export(NodePath) var target_path
export(String) var target_sub_path = 'Head'

export(float) var follow_speed = 10

var target:Spatial

onready var parent = get_parent()

func _ready():
	parent.set_as_toplevel(true)

	if not target_path: return
	target = get_node_or_null(target_path)
	if not target: return
	if not target_sub_path: return
	target = target.get_node(target_sub_path)


func _physics_process(delta):
		parent.global_transform = parent.global_transform.interpolate_with(target.global_transform, delta * follow_speed)
