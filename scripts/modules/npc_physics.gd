extends Node
var velocity: Vector3

var npc: KinematicBody
func _ready():
	npc = get_parent()
	velocity = Vector3()

func _physics_process(delta):
	var orientation = Transform(npc.global_transform.basis, Vector3())
	var anim: AnimationTree = npc.get_meta("animation_tree")
	orientation *= anim.get_root_motion_transform()
	var h_velocity = orientation.origin / delta
	velocity = h_velocity
	velocity += Vector3(0, -9.8, 0) * delta
	velocity = npc.move_and_slide(velocity, Vector3.UP)
	orientation.origin = Vector3()
	orientation = orientation.orthonormalized()
	npc.global_transform.basis = orientation.basis
