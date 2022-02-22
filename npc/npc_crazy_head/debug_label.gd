extends Label

onready var head = $"../headmonster/skeleton/Skeleton/ball"

func _ready():
	set_as_toplevel(true)

func _process(delta):
	if not head: return

	var cam = get_viewport().get_camera()
	if cam:
		var cam_xform = cam.global_transform
		var dir = head.global_transform.origin - cam_xform.origin
		var xdir = cam_xform.xform_inv(dir)
		if xdir.z < 0:
			var pos = cam.unproject_position(head.global_transform.origin + Vector3(0, 1.5, 0))
			pos.x -= rect_size.x / 2.0
			pos.y -= rect_size.y / 2.0
			set_position(pos)
#			if visible:
#				show()
#		else:
#			if visible:
#				hide()
