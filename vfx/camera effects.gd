extends AnimationPlayer

func _ready():
	Game.connect("hp_changed", self, "on_hp")

func on_hp(new, old):
	if new<old:
		stop()
		play("damage_blur")
