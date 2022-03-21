extends Area

onready var parent = owner.get_parent()

# возможно это лучше перенести в скрипт самого  RTS Ammo + сднелать экспортными
var ammo_respawn_delay = 10
var ammo 

func _ready():
	pass



func _on_body_entered(body):
	if body.is_in_group("player"):
		# don't take ammo if already full
		if body.weapon.bullets ==body.weapon.max_bullets: return

		body.weapon.bullets+=30
		body.get_node("AmmoAdded/AnimationPlayer").play("show")
		respawn() # заспавнить через n секунд
		remove()


func respawn():
	yield(get_tree().create_timer(ammo_respawn_delay), "timeout")
	if not is_instance_valid(parent):
		return
	parent.add_child(owner)

func remove():
	yield(get_tree(), "idle_frame") # если не сделать, будет crash игры
	if not parent: return
	parent.remove_child(owner)


