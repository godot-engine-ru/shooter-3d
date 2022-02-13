extends KinematicBody

export (NodePath) var player_nodepath
onready var player:KinematicBody = get_node(player_nodepath)

export (NodePath) var navigation_nodepath
onready var navigation:Navigation = get_node(navigation_nodepath)


export var speed = 10

var path = []
var path_index = 0

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	if not navigation: return
	path = navigation.get_simple_path(global_transform.origin, player.global_transform.origin)
	path_index = 0


var dir:=Vector3.ZERO

func _physics_process(delta):
	if path_index <path.size():
		var direction = path[path_index] - global_transform.origin
		if direction.length()<1:
			path_index+=1
		else:
			
			move_and_slide(direction.normalized()*speed)

			var a = Quat(transform.basis)
			var po = path[path_index]
			po.y = transform.origin.y
			var b = Quat(transform.looking_at(po, Vector3.UP).basis)
			var c = a.slerp(b, 0.08)
			transform.basis = Basis(c)


