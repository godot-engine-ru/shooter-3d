extends ColorRect

onready var max_size = 68

func _ready():
	Game.connect("hp_changed", self, "on_hp")

	update_hp(100)



func on_hp(new_hp:int, old_hp:int):
	
	var recent_hp = Game.player.hp
	update_hp(new_hp)

func update_hp(hp_percent:int):
	var y = range_lerp(hp_percent, 0,100, 0, max_size)
	rect_size.y = y
	rect_position.y = max_size-y
