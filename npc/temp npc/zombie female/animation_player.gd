extends AnimationPlayer

var states = Game.NpcStates

func _ready():
	Game.connect("npc_state_changed", self, "on_state_changed")

func on_state_changed(npc:KinematicBody, state:int):
	if not npc == self: return
	match state:
		states.IDLE:
			stop() # пока нет idle анимации, значит пусть хоть замирает
		states.RUN:
			play("zombie_female_1|run1")
