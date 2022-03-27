extends Button

var active = false setget setter_active

onready var player = $"Label/AnimationPlayer"

const recent:=[null]

func set_recent(node:Control):
	recent[0] = node

func get_recent():
	return recent[0]



func setter_active(val:bool):
	active = val
	
	if val:
#		var recently_pressed:BaseButton = group.__meta__.get("recently_pressed")
		var recently_pressed:BaseButton = recent[0]
#		var pressed_button:BaseButton = group.get_pressed_button()
		if is_instance_valid(recently_pressed):
			recently_pressed.active = false

			recently_pressed.player.stop()
#			recently_pressed.rect_scale.x = 1.0
			recently_pressed.get_node("Label").visible = false
			recently_pressed.player.play_backwards("rect_scale")


		$Label.visible = true
#		rect_scale.x = 1.5
#		rect_scale.y = 1.1

		player.play("rect_scale")
		yield(player,"animation_finished")
		player.play("blink")



func _pressed():
	self.active = true
	recent[0] = self

	# 'эти 3 строки повторяются в другом скрипте, можно вынести
	var panel_container = $"../../../PanelContainer"
	if panel_container.get_child_count():
		panel_container.get_child(0).queue_free()
	


