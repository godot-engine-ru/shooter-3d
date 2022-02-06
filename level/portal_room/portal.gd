extends Spatial

const return_point = "res://level/portal_room/portal_room.tscn"

var run_teleport = false
var teleport_to

func jump_portal(body):
	if body is KinematicBody:
		if has_meta("scene"):
			teleport_to = get_meta("scene")
		else:
			teleport_to = return_point
		run_teleport = true
		set_physics_process(true)

func _ready():
	$a.connect("body_entered", self, "jump_portal")
	set_process(true)
	set_physics_process(false)
	if (has_meta("scene")):
		$display.text = get_meta("scene").replace("res:/", "")
	else:
		$display.text = "Return point"

func _physics_process(delta):
	if run_teleport:
		assert(teleport_to)
		var data = load(teleport_to)
		get_tree().change_scene_to(data)

func _process(delta):
	var cam = get_viewport().get_camera()
	if cam:
		var cam_xform = cam.global_transform
		var dir = global_transform.origin - cam_xform.origin
		var xdir = cam_xform.xform_inv(dir)
		if xdir.z < 0:
			var pos = cam.unproject_position(global_transform.origin + Vector3(0, 1.5, 0))
			pos.x -= $display.rect_size.x / 2.0
			pos.y -= $display.rect_size.y / 2.0
			$display.set_position(pos)
			if !$display.visible:
				$display.show()
		else:
			if $display.visible:
				$display.hide()
