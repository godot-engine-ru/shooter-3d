extends CheckBox

export var singleton:String
export var prop:String

onready var _singleton:Node = get_node("/root/"+singleton)

func _ready():
	pressed = _singleton.get(prop)

func _toggled(button_pressed):
	_singleton.set(prop, button_pressed)
