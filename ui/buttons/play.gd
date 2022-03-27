extends "res://ui/button.gd"


func _on_pressed():
	Menu.hide()
	Game.reload_game()
	get_tree().paused = false
