extends AnimationPlayer

func _ready():
	Game.connect("weapon_reload_started", self, "on_reload_started")

func on_reload_started():
	play("Reload")
	yield(self, "animation_finished")
	Game.emit_signal("weapon_reload_finished")
	
