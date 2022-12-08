extends KinematicBody

onready var Camera = get_node("/root/Game/Camera")

var velocity = Vector3()
var gravity = -9.8
var speed = 0.5
var max_speed = 7
var mouse_sensitivity = 0.002
var jump = 2
var jumping = false


func _ready():
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * speed

	velocity.x += desired_velocity.x
	velocity.z += desired_velocity.z
	var current_speed = velocity.length()
	velocity = velocity.normalized() * clamp(current_speed,0,max_speed)
	$AnimationTree.set("parameters/Idle_Walk/blend_amount", current_speed/max_speed) 
	velocity = move_and_slide(velocity, Vector3.UP, true)
	$Score.text = "Score: " + str(Global.score)



func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -$Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += $Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -$Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += $Camera.global_transform.basis.x
	if Input.is_action_pressed("jump"):
		jumping = true
	if Input.is_action_pressed("sprint"):
		max_speed = 15
	else:
		max_speed = 7
	input_dir = input_dir.normalized()
	return input_dir
