extends RayCast


var recent_enemy_collider:Object

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if !collider == recent_enemy_collider:
			if collider.is_in_group("npc"):
				Game.emit_signal("crosshair_entered_enemy", collider)
				recent_enemy_collider = collider
			else:
				Game.emit_signal("crosshair_exited_enemy")
				recent_enemy_collider = null
			
	elif recent_enemy_collider:
		Game.emit_signal("crosshair_exited_enemy")
		recent_enemy_collider = null
		
		
		
	if recent_enemy_collider and Input.is_action_just_pressed("primary_fire"):
		if recent_enemy_collider.is_in_group("npc"):
			recent_enemy_collider.queue_free()
