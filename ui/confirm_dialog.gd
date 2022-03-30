tool
extends ConfirmationDialog

"""
небольшая модификация для ConfirmationDialog:
	1. заменили текст кнопок на Да, Нет
	2. центрировали текст вопроса

пока не добавили:
	- анимацию появления диалога
	- тему
"""


func _ready():
	get_ok().text = "Да"
	get_cancel().text = "Нет"

	get_label().align = Label.ALIGN_CENTER
	get_label().valign = Label.VALIGN_CENTER
