extends Node

var npc: KinematicBody
var anim: AnimationTree

func _ready():
	npc = get_parent()
	anim = npc.get_meta("animation_tree")
	assert(npc)
	assert(anim)

func _physics_process(delta):
	var cam = get_viewport().get_camera()
	if !cam:
		return
	assert(cam.has_meta("player"))
	var player = cam.get_meta("player")
	if !player:
		return
	var xform: Transform = npc.global_transform
	var lookat = player.global_transform.origin
	lookat.y = npc.global_transform.origin.y
	var distance = xform.origin.distance_squared_to(lookat)
	if distance <= 8.0:
		anim["parameters/state/playback"].travel("attack")
