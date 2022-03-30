extends "res://ui/button.gd"


func _on_pressed():
#	get_tree().quit()
	$QuitDialog.popup_centered()


func _on_QuitDialog_confirmed():
	get_tree().quit()


#func _on_visibility_changed():
#	Menu.is_popup_opened = visible



func _on_QuitDialog_about_to_show():
	Menu.is_popup_opened = true


func _on_QuitDialog_popup_hide():
	Menu.is_popup_opened = false
