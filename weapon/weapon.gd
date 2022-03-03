extends Node

# возможно перенести в др место
onready var raycast:RayCast = $"../Camera/RayCast"

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
		var npc = raycast.recent_enemy_collider
		if !npc: return
		
		if npc is Area:
			npc = npc.owner.get_parent()

		if raycast.recent_enemy_collider.name == "Head":
			var mesh:MeshInstance = npc.get_node("Data").get("head")
			if is_instance_valid(mesh):
				var rigid:RigidBody = npc.get_node("Data").get("head_rigid_body")
				rigid.visible = true
				rigid.set_as_toplevel(true)
#				rigid.get_child(0).global_scale = mesh.global_scale # ugly
#				rigid.global_transform.origin  =mesh.global_transform.origin
				rigid.get_child(0).global_transform = mesh.global_transform # ugly
				mesh.free()
				rigid.mode = rigid.MODE_STATIC
				rigid.mode = rigid.MODE_RIGID
				
#				rigid.apply_central_impulse(raycast.global_transform.xform(rigid.global_transform.origin).normalized()*10)
				
#				rigid.get_parent().remove_child(rigid)
#				npc.get_parent().add_child(rigid)
#				print(rigid)
		
		else:
			npc.get_node("Particles").emitting = true
		

		var npc_hp = npc.get_meta("hp")
		var new_hp = max(0, npc_hp-20)
		if new_hp<=0:
			
			# probably it's better to do this in AnimTree
			(npc.find_node("AnimationPlayer") as AnimationPlayer).play("fall")
			Game.emit_signal("npc_dead", npc)

			npc = npc as KinematicBody
			
			npc.propagate_call("set_physics_process", [0])
			npc.propagate_call("set_physics_process_internal", [0])
			
			npc.propagate_call("set_process", [0])
			
			npc.propagate_call("set_script", [null])
			
#			npc.propagate_call("set_process_internal", [0])
			
			
#			npc.set_physics_process_internal(0)
#			npc.set_process_internal(0)

			npc.set_meta("is_dead", true) # is it needed?
			yield(get_tree().create_timer(10), "timeout")
	
			
			if is_instance_valid(npc):
				npc.free()
				return

		if is_instance_valid(npc):
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
