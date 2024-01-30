extends CharacterBody2D

@onready var label = $Label
@onready var undead_state_machine = $UndeadStateMachine

@onready var sprite = $Sprite2D

@onready var target = Global.player
@export var speed : float = 300  
@onready var director = $".."
@onready var aggro_area = $AggroArea
@onready var hurtbox = $Hurtbox
@onready var flip = false


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
	
	if Input.is_action_just_pressed("right_click"):
		toggle_hitbox()
		if flip:
			skew = -50
		else:
			skew = 50
	if Input.is_action_just_released("right_click"):
		toggle_hitbox()
		skew = 0
	
	# FIXME: visuals altering code in bad spot
	if velocity.x < 0:
		sprite.set_flip_h(true)
	elif velocity.x > 0:
		sprite.set_flip_h(false)
func toggle_hitbox():
	if hurtbox.is_monitorable():
		hurtbox.set_deferred("monitorable", false)
		hurtbox.hide()
	else:
		hurtbox.set_deferred("monitorable", true)
		hurtbox.show()
		
	if hurtbox.is_monitoring():
		hurtbox.set_deferred("monitoring", false)
		hurtbox.hide()
	else:
		hurtbox.set_deferred("monitoring", true)
		hurtbox.show()
