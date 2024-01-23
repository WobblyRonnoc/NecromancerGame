extends CharacterBody2D

@onready var right_hand = $RightHand
var rh_vector


@onready var wheel = $AnalogInputViewer
@onready var radius = wheel.radius / 2
@onready var terror_area = $TerrorArea

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0

func raise_hand():
	rh_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
	right_hand.position.x = wheel.position.x * 0.25 + rh_vector.x * radius
	right_hand.position.y = wheel.position.y/2 + rh_vector.y * radius
	right_hand.position.clamp(position, rh_vector * radius)
		
func emit_terror(state: bool):
	terror_area.get_child(0).set_deferred("disabled", state)

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
func _on_terror_area_entered(area):
	pass
		
