tool
extends RichTextLabel

var members_list = """
[color=#{c1}]pigzinzspace:[/color] [color=#{c2}]геймдизайн[/color]
[color=#{c1}]me2beats:[/color] [color=#{c2}]код, саундтрек, менеджмент проекта[/color]
[color=#{c1}]slapin:[/color] [color=#{c2}]код[/color]
[color=#{c1}]soundsbeard:[/color] [color=#{c2}]3D[/color]
[color=#{c1}]Абдурахман:[/color] [color=#{c2}]3D[/color]
[color=#{c1}]Gamma:[/color] [color=#{c2}]2D[/color]
[color=#{c1}]Polis:[/color] [color=#{c2}]2D[/color]
"""

var c1 = "ed1c24"
#var col2 = "000000"
var c2 = "7f6d6d"

func _enter_tree():

	bbcode_text = members_list.format({c1=c1, c2=c2})

