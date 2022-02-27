extends Spatial

var respawn_delay = 10

onready var parent = get_parent()

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.hp == 100: return
		body.hp +=25
		body.get_node("HpAdded/AnimationPlayer").play("show")
		respawn()
		remove()


func respawn():
	yield(get_tree().create_timer(respawn_delay), "timeout")
	if not is_instance_valid(parent):
		print("instance not valid")
		return
	parent.add_child(self)

func remove():
	yield(get_tree(), "idle_frame") # если не сделать, будет crash игры
	if not parent: return
	parent.remove_child(self)
