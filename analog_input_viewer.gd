extends Node2D

var radius : float = 31
@onready var analog = $AnalogPosition
@onready var back = $back

func _process(delta):
	var analog_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)
	
	Global.analog_position = analog.position
	Global.analog_angle = rad_to_deg(back.position.angle_to(analog.position))
	
	# FIXME: this is gross
	if (Global.analog_angle > -45.0 && Global.analog_angle < 45.0) || (Global.analog_angle > -145.0 && Global.analog_angle < 360.0 || Global.analog_angle < 145.0 && Global.analog_angle < 180.0 ):
		analog.position.y = 0
	
	if (Global.analog_angle > -145.0 && Global.analog_angle < -45.0):
		analog.position.x = 0
	
