extends Control
@onready var l_label = $"../AnalogInputViewer/MarginContainer/PanelContainer/VBoxContainer/Label"
@onready var l_label_2 = $"../AnalogInputViewer/MarginContainer/PanelContainer/VBoxContainer/Label2"
@onready var l_label_3 = $"../AnalogInputViewer/MarginContainer/PanelContainer/VBoxContainer/Label3"

@onready var r_label = $"../AnalogInputViewer2/MarginContainer2/PanelContainer/VBoxContainer/Label"
@onready var r_label_2 = $"../AnalogInputViewer2/MarginContainer2/PanelContainer/VBoxContainer/Label2"
@onready var r_label_3 = $"../AnalogInputViewer2/MarginContainer2/PanelContainer/VBoxContainer/Label3"

func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += str(i)
	return s
	
func create_label(text): 
	var label = Label.new() 
	$"../VBoxContainer".add_child(label, true)
	$"../VBoxContainer".get_child($"../VBoxContainer".get_child_count()).text = text
	
	
func _process(_delta):
	l_label.text = "Analog Position: ({},{})".format([roundf(Global.l_analog_position.x), roundf(Global.l_analog_position.y)], '{}')
	l_label_2.text = "Angle: %d" % Global.l_analog_angle
	l_label_3.text = "Spell ID: " + array_to_string(Global.left_spell_key)

	r_label.text = "Analog Position: ({},{})".format([roundf(Global.r_analog_position.x), roundf(Global.r_analog_position.y)], '{}')
	r_label_2.text = "Angle: %d" % Global.r_analog_angle
	r_label_3.text = "Spell ID: " + array_to_string(Global.right_spell_key)
	
func returned_to_center(side):
	if side == 0:
		create_label(Global.left_spell_key)
		Global.left_spell_key.clear()
	else:
		create_label(Global.left_spell_key)
		Global.right_spell_key.clear()
		
	for child in get_children():
		if child.name.contains("SpellPoint"):
			child.selected = false
