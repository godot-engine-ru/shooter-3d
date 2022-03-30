extends VBoxContainer



func _ready():
	set_process_input(0)
	yield(get_tree().create_timer(0.2),"timeout")
	var first = get_child(0)
	
	first._pressed()
	first.grab_focus()
	set_process_input(1)

func get_focused_idx():
	for i in get_child_count():
		var child = get_child(i)
		if child.has_focus():
			return i
	return -1

func _input(event):
	
	event = event as InputEventKey
	if !event or !event.pressed: return

	if not Menu.visible: return
	if Menu.is_popup_opened: return

	if event.is_action("ui_down"):
		
		
#		var first = get_child(0)
#		var found:int = get_children().find(first.group.__meta__.get("recently_pressed"))
		var found:int = get_focused_idx()
		if found == -1: found = 0
		var next:BaseButton = get_child(clamp(found+1, 0, get_child_count()-1))


		next._pressed()
		next.grab_focus()
		accept_event()

	elif event.is_action("ui_up"):
		var found:int = get_focused_idx()
#		var first = get_child(0)
#		var found:int = get_children().find(first.group.__meta__.get("recently_pressed"))
		if found == -1: found = 0
		var next:Node = get_child(clamp(found-1, 0, get_child_count()-1))
		next._pressed()
#		first.group.set_meta("recently_pressed", next)
		next.grab_focus()
		next.grab_focus()
		accept_event()
