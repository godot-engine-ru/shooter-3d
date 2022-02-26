extends Control

# скрипт для Автомата Vector D

var bullets:int setget setter_bullets

# патронов в обойме в данный момент
var current_bullet_count:int

var bullets_left:int

# максимально патронов в обойме
var clip_size = 30

func setter_bullets(val:int):
	if Game.shoot_state: # нужно ли, если уже есть проверка, при если юзать try_shoot
		print("не могу стрелять")
		return
	val = max(val, 0)
	var new_current = val%clip_size
	
	if new_current == 0 and val:
		new_current = clip_size

	current_bullet_count = new_current
	bullets_left = val-current_bullet_count

	bullets = val
	
	if val == 0:
		Game.shoot_state = Game.ShootStates.NO_AMMO
	
	# апдейтим чиселки на контролах
	$Current.text = str(current_bullet_count)
	$Other.text = str(bullets_left)

func _ready():
#	Game.connect("shoot_gun", self, "on_shoot_gun")
	self.bullets = 60

#
#func on_shoot_gun(gun_type):
#	self.bullets-=1
