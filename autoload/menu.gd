extends Control

var is_popup_opened = false


func _ready():
	visible = true

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
	remove_child(get_children()[-1])
	add_child(preload("res://ui/fail.tscn").instance())
	
	yield(get_tree(),"idle_frame")
	if not visible:
		visible = true
	
#	get_children()[-1].show()





var trans = Tween.TRANS_QUART
var trans_time = 0.6
var opacity_multiplier = 0.6

var scale_multiplier = 0.7

func change_page_to(scene_filename:String, anim_back: = false):

#	yield(get_tree().create_timer(0.5),"timeout")
	var scene:Control = load(scene_filename).instance()
	var start_x = rect_size.x if not anim_back else -rect_size.x
	
	scene.margin_left = start_x
	scene.rect_scale = Vector2.ONE*scale_multiplier
	scene.modulate.a = 0.0
#	scene.rect_position.x = rect_size.x

	var recent_page = get_children()[-1]
	add_child(scene)
	
#	set_as_toplevel(1)
	$Tween.interpolate_property(recent_page, "rect_position:x", 0, -start_x, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(recent_page, "rect_scale", Vector2.ONE, Vector2.ONE*scale_multiplier, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(recent_page, "modulate:a", 1.0, 0.0, trans_time*opacity_multiplier, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "margin_left", scene.margin_left, 0, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "modulate:a", 0.0, 1.0, trans_time*opacity_multiplier, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "rect_scale", Vector2.ONE*scale_multiplier, Vector2.ONE, trans_time, trans, Tween.EASE_IN_OUT)
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	recent_page.queue_free()




