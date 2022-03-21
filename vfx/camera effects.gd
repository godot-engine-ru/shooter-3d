extends AnimationPlayer

func _ready():
	Game.connect("hp_changed", self, "on_hp")


	yield(get_tree(), "idle_frame")
	play("RESET")
	

func on_hp(new, old):
	if new<old:
		stop()
		play("damage_blur")
