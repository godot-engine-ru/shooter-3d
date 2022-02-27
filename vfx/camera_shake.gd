extends Node

onready var camera:Camera = get_parent()

var shake_amount = 0.005
var is_shake = false


func _process(delta):
	if is_shake:
		var v = Vector2(rand_range(-1.0, 1.0)*shake_amount, rand_range(-1.0, 1.0)*shake_amount)
		camera.h_offset = v.x
		camera.v_offset = v.y

#export var shake_power = 0.01
#var is_shake = false
#export var shake_time = 0.4
#
#var cur_pos:Vector2
#var elapsed_time = 0
#
#func _ready():
#	randomize()
#	cur_pos.x = camera.h_offset
#	cur_pos.y = camera.v_offset
#
#
#func _process(delta):
#	if is_shake:
#		shake(delta)
#
#func shake(delta):
#	if elapsed_time<shake_time:
#		var v = Vector2(randf(), randf())*shake_power
#		camera.h_offset = v.x
#		camera.v_offset = v.y
#		elapsed_time+=delta
#	else:
#		is_shake = false
#		elapsed_time = 0
#		camera.h_offset = cur_pos.x
#		camera.v_offset = cur_pos.y

