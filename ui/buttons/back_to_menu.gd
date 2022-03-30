extends "res://ui/button.gd"


func _on_pressed():
	Menu.change_page_to("res://ui/main_menu.tscn", true)
