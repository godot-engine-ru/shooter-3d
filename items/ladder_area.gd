extends Area


func _on_body_entered(body):
	body = body as KinematicBody
	if not body: return
	print(body)
	if not body.is_in_group("player"): return
	Game.emit_signal("ladder_entered")



func _on_body_exited(body):
	body = body as KinematicBody
	if not body: return
	print(body)
	if not body.is_in_group("player"): return
	Game.emit_signal("ladder_exited")
