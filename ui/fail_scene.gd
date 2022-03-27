extends Control

func _on_visibility_changed():
	$MarginContainer/ButtonsContainer._ready() # ugly
