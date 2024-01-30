class_name Player
extends CharacterBody2D

@onready var state_machine = $PlayerStateMachine

@onready var right_hand = $RightHand

@onready var wheel = $AnalogInputViewer
@onready var radius = wheel.radius / 2
@onready var sprite = $Sprite

@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

var flip = false

var gravity = 0

func raise_hand():
	var resting_pos = Vector2(0,-48)
	right_hand.show()
	var rh_vector
	if flip:
		right_hand.position.x *= -1
	if !flip:
		right_hand.position.x = abs(right_hand.position.x)
	rh_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
	right_hand.position.x = rh_vector.x * radius
	right_hand.position.y = rh_vector.y * radius
	right_hand.position.clamp(right_hand.position, rh_vector * radius)
	
	
func move():
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _ready():
	Global.player = self
	Global.wheel_ui = wheel

func _process(delta):
	#flip the 'sprite'
	if Input.is_action_just_pressed("ui_left"):
		flip = true
		sprite.scale.x = -1
	elif Input.is_action_just_pressed("ui_right"):
		flip = false
		sprite.scale.x = 1

