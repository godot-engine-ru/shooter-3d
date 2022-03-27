extends "res://ui/button.gd"


func _on_pressed():
#	get_tree().quit()
	$QuitDialog.popup_centered()


func _on_QuitDialog_confirmed():
	get_tree().quit()
