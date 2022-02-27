extends Control



# скрипт для Автомата Vector D

var bullets:int setget setter_bullets

# патронов в обойме в данный момент
var current_bullet_count:int

var bullets_left:int

# максимально патронов в обойме
var clip_size = 30

var bullets_initial_count = 60

var max_bullets = 150

func setter_bullets(val:int):
	val = clamp(val, 0, max_bullets)
	
	if val and Game.shoot_state == Game.ShootStates.NO_AMMO:
		Game.shoot_state = 0
	
	if !val:
		bullets = 0
		current_bullet_count = 0
		bullets_left = 0
		update_hud()
		Game.shoot_state = Game.ShootStates.NO_AMMO
		return


	if val==bullets:
		if !current_bullet_count==clip_size and bullets_left and not current_bullet_count==clip_size:
			current_bullet_count = min(bullets, clip_size)
			bullets_left = bullets-current_bullet_count
			
			Game.emit_signal("weapon_reload_started")
			yield(Game, "weapon_reload_finished")


	elif val>bullets:
		bullets = val
		current_bullet_count = min(val, clip_size)
		bullets_left = val-current_bullet_count
		
	
	else:
		# now only works like -=1 bullet, even if you write bullets-=10 etc
		bullets-=1
		if current_bullet_count == 1:
			current_bullet_count = 0
			update_hud()

			Game.emit_signal("weapon_reload_started")
			yield(Game, "weapon_reload_finished")
			
			current_bullet_count = min(clip_size, bullets)
			bullets_left = bullets-current_bullet_count
			
		else:
			current_bullet_count -= 1

	update_hud()

	return
	
	
	


onready var _current = $Current
onready var _other = $Other

func update_hud():
	_current.text = str(current_bullet_count)
	_other.text = str(bullets_left)



func _ready():
#	Game.connect("shoot_gun", self, "on_shoot_gun")
	self.bullets = bullets_initial_count

