extends Node

# возможно перенести в др место
onready var raycast = $"../Camera/RayCast"

func try_shoot():

	if !Game.shoot_state:
		Game.emit_signal("shoot_gun", Game.GunTypes.AUTO)

		if $WeaponHUD.bullets==0:
	
			Game.shoot_state = Game.ShootStates.NO_AMMO
			print("no ammo")
			return

		$WeaponHUD.bullets-=1


		# обработка попадания в зомби
		var npc:KinematicBody = raycast.recent_enemy_collider
		if !npc: return
		
		var npc_hp = npc.get_meta("hp")
		var new_hp = max(0, npc_hp-20)
		if new_hp<=0:
			npc.queue_free()

		npc.set_meta("hp", npc_hp-20)
		
		print(new_hp)




func _ready():
	var player = Game.player
	player.weapon = self


func _input(event):
	event = event as InputEventMouseButton
	if not event or not event.is_pressed(): return
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE: return
	match event.button_index:
		BUTTON_LEFT:
			try_shoot()

		BUTTON_RIGHT:
			Game.emit_signal("weapon_reload")
