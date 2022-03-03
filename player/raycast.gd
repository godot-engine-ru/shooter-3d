extends RayCast


var recent_enemy_collider:Object

enum BodyParts {
	BODY,
	HEAD
}

var recent_body_part:int

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if not collider: return
		if !collider == recent_enemy_collider:
#			if collider.is_in_group("npc"):
			match collider.name:
				"Body", "Head":
					Game.emit_signal("crosshair_entered_enemy", collider)
					recent_enemy_collider = collider
					
					recent_body_part = BodyParts.get(collider.name, -1)
					
				_:
					Game.emit_signal("crosshair_exited_enemy")
					recent_enemy_collider = null
					recent_body_part = -1

	elif recent_enemy_collider:
		Game.emit_signal("crosshair_exited_enemy")
		recent_enemy_collider = null
		recent_body_part = -1
		
		
#	if recent_enemy_collider and Input.is_action_just_pressed("primary_fire"):
#		if recent_enemy_collider.is_in_group("npc"):
#
#
##				Game.emit_signal("weapon_shoot")
#				Game.player.weapon.try_shoot()
