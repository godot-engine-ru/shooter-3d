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

signal hp_changed(new_hp, old_hp)
signal hp_is_0

var player:KinematicBody

# gun_type = см. GunTypes
signal shoot_gun(gun_type)

# npc - нода зомби (Kinematic)
# state - int состояние (идет, бежит, атакует..)
signal npc_state_changed(npc, state)


signal ladder_entered
signal ladder_exited

var current_weapon

# варианты состояний стрельбы
enum ShootStates {
	CAN_SHOOT,
	NO_AMMO,
	NO_WEAPON,
	RELOADING,
	COOLDOWN,
	
}
var shoot_state = ShootStates.CAN_SHOOT

signal weapon_reload

# пул объектов, например боеприпасы:
# игрок зашел в Area боеприпаса - получил патроны, сцену Ammo-бокса удалили из дерева
# и добавляем ее напр по таймеру
var pool = {}


func reload_game():
	get_tree().call_group("npc", "free")
	get_tree().reload_current_scene()


func _input(event):
	event = event as InputEventKey
	if not event or not event.pressed or not event.scancode == KEY_F5:
		return
	get_tree().set_input_as_handled()

	reload_game()

