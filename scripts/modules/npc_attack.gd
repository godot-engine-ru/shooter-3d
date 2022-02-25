extends Node

var npc: KinematicBody
var anim: AnimationTree

var timer:Timer
var npc_can_attack = false

func _ready():
	npc = get_parent()
	anim = npc.get_meta("animation_tree")
	assert(npc)
	assert(anim)

	timer = Timer.new()
	timer.wait_time = 1.5
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")

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
#	lookat.y = npc.global_transform.origin.y
	var distance = xform.origin.distance_squared_to(lookat)
	if distance <= 8.0:
		anim["parameters/state/playback"].travel("attack")

	# временное решение для реализации дамага от зомби=====
		if not npc_can_attack:
			make_damage()
			timer.start()
			npc_can_attack = true
	else:
		
		npc_can_attack = false
		if !timer.is_stopped():
			timer.stop()
	#======================================================

func on_timeout():
	if not npc_can_attack: return
	make_damage()

func make_damage():

	var hp = Game.player.hp
	var new_hp = max(0, hp-4)
	Game.emit_signal("hp_changed", new_hp, hp)
	Game.player.hp = new_hp
	if new_hp ==0:
		Game.reload_game()
	print("damage from npc")
