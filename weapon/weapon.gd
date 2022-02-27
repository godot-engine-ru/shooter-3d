extends Node

# возможно перенести в др место
onready var raycast = $"../Camera/RayCast"

onready var camera_shake_node = get_viewport().get_camera().get_node("Shake")

var bullets:int setget setter_bullets, getter_bullets
var max_bullets:int setget , getter_max_bullets

func setter_bullets(val):
	$WeaponHUD.bullets = val

func getter_bullets():
	return $WeaponHUD.bullets

func getter_max_bullets():
	return $WeaponHUD.max_bullets
	

func try_shoot():

	if !Game.shoot_state:
		Game.emit_signal("shoot_gun", Game.GunTypes.AUTO)

		camera_shake_node.is_shake = true
		$WeaponHUD.bullets-=1


		# обработка попадания в зомби
		var npc:KinematicBody = raycast.recent_enemy_collider
		if !npc: return
		
		var npc_hp = npc.get_meta("hp")
		var new_hp = max(0, npc_hp-20)
		if new_hp<=0:
			npc.queue_free()

		npc.set_meta("hp", npc_hp-20)
		
	else:
		camera_shake_node.is_shake = false


func try_reload():
	
	self.bullets = self.bullets
	
	if Game.shoot_state == Game.ShootStates.RELOADING: return
	
#	Game.emit_signal("weapon_reload_started")

func _ready():
	var player = Game.player
	player.weapon = self


func _input(event):
	event = event as InputEventMouseButton
	if not event: return
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE: return
	if event.is_pressed():
		match event.button_index:
			BUTTON_LEFT:
				$Timer.start()


			BUTTON_RIGHT:
				try_reload()
	else:
		$Timer.stop()
		camera_shake_node.is_shake = false


func _on_timeout():
	try_shoot()
