extends KinematicBody


export var speed = 7
export var ACCEL_DEFAULT = 7
export var ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 9.8
export var jump = 5

export var cam_accel = 40
export var mouse_sense = 0.1
var snap

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

var ladder_speed = 4
var ladder_accel = 0.1

onready var head = $Head

onready var camera = $Camera

var is_mouse_visible = false

var is_on_ladder = false


var fall_start_height:=0


# свойство, кот используем чтобы установить конкретный hp
var hp:int setget setter_hp

func setter_hp(new_hp:int):
	var new_hp_real = clamp(new_hp, 0, 100)
	
	if new_hp_real <=0:
		Game.emit_signal("hp_is_0")
		Game.reload_game()
	
	Game.emit_signal("hp_changed", new_hp_real, hp)
	hp = new_hp_real


var weapon:Node


func _enter_tree():
	Game.player = self

func _ready():
	self.hp = 100
	
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#	$Camera.set_meta("player", self)
	get_viewport().get_camera().set_meta("player", self)


	Game.connect("ladder_entered", self, "on_ladder_entered")
	Game.connect("ladder_exited", self, "on_ladder_exited")


func on_ladder_entered():
	is_on_ladder = true
	
func on_ladder_exited():
	is_on_ladder = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		match Input.get_mouse_mode():
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				is_mouse_visible = false
				get_tree().paused = false

			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				is_mouse_visible = true
				get_tree().paused = true

	#get mouse input for head rotation
	if event is InputEventMouseMotion:
		if is_mouse_visible: return
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

		
func _physics_process(delta):
	
	if is_on_ladder:
		move_on_ladder()
	else:
		direction = Vector3.ZERO
		var h_rot = global_transform.basis.get_euler().y
		var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
		var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()


		#======== падение и урон от него=================
		if is_on_floor():
			if fall_start_height:
				var fall_height = fall_start_height-translation.y
				if fall_height>7:
					var damage = fall_height*2
					print("урон от падения: ", damage)
					self.hp -= damage


				fall_start_height = 0
		else:
			if not fall_start_height:
				fall_start_height = translation.y
		#===============================================

		#jumping and gravity
		if is_on_floor():
			snap = -get_floor_normal()
			accel = ACCEL_DEFAULT
			gravity_vec = Vector3.ZERO
		else:
			snap = Vector3.DOWN
			accel = ACCEL_AIR
			gravity_vec += Vector3.DOWN * gravity * delta
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			snap = Vector3.ZERO
			gravity_vec = Vector3.UP * jump
		
		#make it move
		velocity = velocity.linear_interpolate(direction * speed, accel * delta)
		movement = velocity + gravity_vec
		
		move_and_slide_with_snap(movement, snap, Vector3.UP)



func move_on_ladder():


	var up = Input.is_action_pressed("move_forward")
	var down = Input.is_action_pressed("move_backward")
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var aim = camera.get_camera_transform().basis

	direction = Vector3()

	if up:
		direction -= aim[2]
	if down:
		direction += aim[2]
	if left:
		direction -= aim[0]
	if right:
		direction += aim[0]

	direction = direction.normalized()

	var target = direction * ladder_speed

	velocity = velocity.linear_interpolate(target, ladder_accel)

	move_and_slide(velocity)
