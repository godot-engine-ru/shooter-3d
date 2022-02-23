extends Node

var stop_navigation = false

# пути к файлам материалов, для которых устанавливать xray - чтобы видеть npc сквозь стены, для дебага
# устанавливаем в сцене debug.tscn, чтобы не лазить в этот скрипт
export (Array, String) var materials_for_xray_paths

# сами ресурсы материалов, где будем менять next pass в зависимости от настройки debug xray (вкл/выкл).
var materials_for_xray:Array
var xray_next_pass_mat:Material = preload("res://npc/xray_mat.tres")

export var use_xray: = true setget setter_xray

func _ready():
	# добавляем ресурсы в materials_for_xray
	var mat_count = materials_for_xray_paths.size()
	materials_for_xray.resize(mat_count)
	for i in mat_count:
		materials_for_xray[i] = load(materials_for_xray_paths[i])

	set_xray(use_xray)

func setter_xray(is_active):
	use_xray = is_active
	set_xray(is_active)

func set_xray(is_active):
	for m in materials_for_xray:
		if is_active:
			m  = m as SpatialMaterial
			m.next_pass = xray_next_pass_mat
		else:
			m  = m as SpatialMaterial
			m.next_pass = null
