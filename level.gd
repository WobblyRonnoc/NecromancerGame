extends Node2D

@onready var ls_display = $AnalogInputViewer
@onready var rs_display = $AnalogInputViewer2

func _process(delta):
	if Input.is_action_just_pressed("rt"):
		rs_display.show()
	if Input.is_action_just_released("rt"):
		rs_display.hide()
		
	if Input.is_action_just_pressed("lt"):
		ls_display.show()
	if Input.is_action_just_released("lt"):
		ls_display.hide()
		
