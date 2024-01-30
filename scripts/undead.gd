extends CharacterBody2D

@onready var label = $Label
@onready var undead_state_machine = $UndeadStateMachine

@onready var target = Global.player
@export var speed : float = 300  
@onready var director = $".."
@onready var aggro_area = $AggroArea


func manual_move():
	var x_direction = Input.get_axis("rs_left", "rs_right")
	var y_direction = Input.get_axis("rs_up", "rs_down")
	
	if x_direction:
		velocity.x = x_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if y_direction:
		velocity.y = y_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

func _ready():
	global_position = Global.cursor.global_position
	
func _process(delta):
	var state = undead_state_machine.CURRENT_STATE.name
	label.text = str(state)
