extends Node2D

#TODO: lock to cardinal until at edge (no changing mind before done reaching for edge)

@export var radius : float = 31
@onready var id_coords : Dictionary = {"up": Vector2(0, -radius), "right": Vector2(radius, 0), "Down": Vector2(0, radius), "left": Vector2(-radius, 0)}

@onready var analog = $AnalogPosition
@onready var back = $back
@onready var analog_vector

func _process(delta):
	Global.analog_position = analog.position
	Global.analog_angle = rad_to_deg(back.position.angle_to(analog.position))
	
	analog_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down",-1.0)
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)
	
	if analog.position.length() < 28:
		lock_to_cardinals()
	else:
		analog.scale.x = 20
		analog.scale.y = 20
		
func lock_to_cardinals():
	analog.scale.x = 10
	analog.scale.y = 10

	# lock the position to cardinals until at the outer circumference

	#up
	if (Global.analog_angle > -145.0 && Global.analog_angle < -45.0):
		analog.position.x = 0

	#down
	if (Global.analog_angle < 145.0 && Global.analog_angle > 45.0):
		analog.position.x = 0

	#right
	if (Global.analog_angle > -45.0 && Global.analog_angle < 45.0):
		analog.position.y = 0

	#left
	if ( (Global.analog_angle < -145.0 && Global.analog_angle > -179.0) || (Global.analog_angle > 145.0 && Global.analog_angle < 180.0) ):
		analog.position.y = 0
