extends Node

signal crosshair_entered_enemy
signal crosshair_exited_enemy

enum GunTypes {
	PISTOL,
	AUTO,
	GRENADE,
	#..
}

# сейчас очень упрощенно
# walk - мирно гуляет, патрулирует (можно назвать patrol)
# run - гонится за игроком (можно назвать chase)
# attack - атакует.
enum NpcStates {
	IDLE,
	WALK,
	RUN,
	ATTACK,
}

# gun_type = см. GunTypes
signal shoot_gun(gun_type)

# npc - нода зомби (Kinematic)
# state - int состояние (идет, бежит, атакует..)
signal npc_state_changed(npc, state)

func reload_game():
#	get_tree().change_scene_to(preload("res://level/level1.tscn"))
	get_tree().change_scene_to(preload("res://proto/plan test.tscn"))


func _input(event):
	event = event as InputEventKey
	if not event or not event.pressed or not event.scancode == KEY_F5:
		return
	get_tree().set_input_as_handled()

	reload_game()
