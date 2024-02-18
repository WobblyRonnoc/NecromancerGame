class_name Player
extends CharacterBody2D

@onready var state_machine = $PlayerStateMachine
@onready var right_hand = $RightHand
@onready var hand_origin = $HandOrigin
@onready var wheel = $AnalogInputViewer
@onready var radius = wheel.radius / 2
@onready var sprite = $AnimatedSprite2D
@onready var animated_hand = $AnimatedHand


@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

var flip = false

var gravity = 0

func face_move_direction():
	#flip the 'sprite'
	if Input.is_action_just_pressed("ui_left"):
		flip = true
		sprite.scale.x *= -1
		animated_hand.position.x *= -1
	elif Input.is_action_just_pressed("ui_right"):
		flip = false
		sprite.scale.x *= 1
		animated_hand.position.x *= 1

func raise_hand():
	#right_hand.show()
	animated_hand.look_at(right_hand.global_position)
	animated_hand.global_rotation_degrees += -90
	
	if flip:
		right_hand.position.x *= -1
	else:
		right_hand.position.x = abs(right_hand.position.x)
		
	var rh_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
	right_hand.position = hand_origin.position + rh_vector * radius

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
	sprite.play("Idle")
func _process(delta):
	face_move_direction()

