extends Control


func _ready():
	Game.connect("game_over", self, "on_gameover")


func on_gameover():
	show_gameover()
	var player = Game.player
	player.pause_mode = PAUSE_MODE_STOP


	grab_focus()
#	grab_click_focus()

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


	yield(get_tree(), "idle_frame")
	if not get_parent().get_child_count()-1 == get_index():
		get_parent().move_child(self, get_parent().get_child_count()-1)

	
#	$Tween.interpolate_property(Engine, "time_scale", 1, 0, 3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
#	$Tween.start()
#	yield($Tween, "tween_completed")
	get_tree().paused = true
#	Engine.time_scale = 1.0

func show_gameover():
	yield(get_tree(),"idle_frame")
	if not visible:
		visible = true
	
	$Fail.show()
