extends "res://ui/button.gd"

var ru = true

func _on_pressed():
	ru = not ru
	if ru:
		text = "ЯЗЫК ru"
	else:
		text = "LANGUAGE en"
