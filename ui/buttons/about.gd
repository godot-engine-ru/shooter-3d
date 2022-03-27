extends "res://ui/button.gd"


func _on_pressed():
	var panel_container = $"../../../PanelContainer"
	if panel_container.get_child_count():
		panel_container.get_child(0).queue_free()
	
	var about_panel = preload("res://ui/panels/about.tscn").instance()
	panel_container.add_child(about_panel)
	
	
#	Menu.hide()
#	Game.reload_game()
#	get_tree().paused = false
