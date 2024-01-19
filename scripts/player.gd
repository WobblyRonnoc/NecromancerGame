extends CharacterBody2D

@onready var left_hand = $LeftHand
@onready var right_hand = $RightHand
var rh_vector
var lh_vector

@onready var wheel = $AnalogInputViewer
@onready var wheel2 = $AnalogInputViewer2
@onready var radius = wheel.radius / 2
@onready var terror_area = $TerrorArea

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var wheels = [wheel, wheel2]

signal cast(spell_id : String)
enum STATES {
	IDLE,
	IMMOBILE,
	CASTING
}
var current_state = STATES.IDLE







# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0

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
		
func raise_hand(hand):
	if hand == "left":
		lh_vector = Input.get_vector("ls_left","ls_right","ls_up","ls_down",-1.0)
		left_hand.position.x = wheel.position.x * 0.25 + lh_vector.x * radius
		left_hand.position.y = wheel.position.y /2 + lh_vector.y * radius
		left_hand.position.clamp(position, lh_vector * radius)
			
	if hand == "right":
		rh_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
		right_hand.position.x = wheel2.position.x * 0.25 + rh_vector.x * radius
		right_hand.position.y = wheel2.position.y/2 + rh_vector.y * radius
		right_hand.position.clamp(position, rh_vector * radius)
		
# FIXME get the specific trigger! USE SIGNALS!!!!!!!!!!!!!
func listen_for_casting_input():
	Global.debug.add_property("Player is scary", !terror_area.get_child(0).disabled,2)
	if wheels.any(func(x):
		return x.is_trigger_pulled() 
		):
		terror_area.get_child(0).set_deferred("disabled", false)
	else:
		terror_area.get_child(0).set_deferred("disabled", true)
	
func _physics_process(delta):
	if Input.get_action_strength("lt") == 0.0:
		move()

func _process(delta):
	listen_for_casting_input()
	if Input.get_action_strength("lt") != 0.0:
		raise_hand("left")
		
	if Input.get_action_strength("rt") != 0.0:
		raise_hand("right")
		
func _on_terror_area_entered(area):
	var npc = area.get_parent()
	if area.is_in_group("fear_area"):
		npc.current_state = npc.STATES.RUN
		
