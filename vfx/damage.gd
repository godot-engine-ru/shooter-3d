extends TextureRect

func _ready():
	Game.connect("hp_changed", self, "on_hp")

func on_hp(new_hp:int, old_hp:int):
	if new_hp-old_hp<0:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("show")
