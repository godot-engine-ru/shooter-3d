extends Control

var trans = Tween.TRANS_QUART
var trans_time = 0.6
var opacity_multiplier = 0.6

var scale_multiplier = 0.7

func _on_Button3_pressed():



#	yield(get_tree().create_timer(0.5),"timeout")
	var scene:Control = load(filename).instance()
	scene.margin_left = rect_size.x
	scene.rect_scale = Vector2.ONE*scale_multiplier
	scene.modulate.a = 0.0
#	scene.rect_position.x = rect_size.x
	get_parent().add_child(scene)
	
#	set_as_toplevel(1)
	$Tween.interpolate_property(self, "rect_position:x", 0, -rect_size.x, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "rect_scale", Vector2.ONE, Vector2.ONE*scale_multiplier, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, trans_time*opacity_multiplier, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "margin_left", scene.margin_left, 0, trans_time, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "modulate:a", 0.0, 1.0, trans_time*opacity_multiplier, trans, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(scene, "rect_scale", Vector2.ONE*scale_multiplier, Vector2.ONE, trans_time, trans, Tween.EASE_IN_OUT)
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()


func _on_Button_pressed():
	Menu.hide()
	Game.reload_game()
	get_tree().paused = false




func _on_visibility_changed():
	$MarginContainer/HBoxContainer._ready()
