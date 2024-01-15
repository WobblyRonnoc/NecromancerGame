extends Control

@onready var label = $MarginContainer/PanelContainer/VBoxContainer/Label
@onready var label2 = $MarginContainer/PanelContainer/VBoxContainer/Label2

func _process(_delta):
	label.text = "Analog Position: ({},{})".format([roundf(Global.analog_position.x), roundf(Global.analog_position.y)], '{}')
	label2.text = "Angle: %d" % Global.analog_angle
