extends Node

var debug
var debug2

var l_analog_angle = 0.0
var l_analog_position = Vector2.ZERO

var r_analog_angle = 0.0
var r_analog_position = Vector2.ZERO

var left_spell_key : Array = []
var right_spell_key : Array = []

const SPELL_LIST : Dictionary = {
	"120" : "Fire Ball",
	"1230": "Buff AoE",
	"103" : "Rend Flesh",
	"14023" : "Line AoE",
	"41230" : "Sheild"
	}

func get_spell_key(stick):
	if stick == 0:
		return left_spell_key
	if stick == 1:
		return right_spell_key
		
func set_spell_key(stick, value: Array):
	if stick == 0:
		left_spell_key = value
	if stick == 1:
		right_spell_key = value
		
func clear_spell_key(stick):
	if stick == 0:
		left_spell_key.clear()
	if stick == 1:
		right_spell_key.clear()
func _process(_delta):
	debug.add_property("Queued [LEFT] Spell ID", left_spell_key, 0)
	#debug.add_property_bar("[LEFT]Trigger Strength", Input.get_action_strength("lt"), 1)
	
	debug.add_property("Queued [RIGHT] Spell ID", right_spell_key, 3)
	#debug.add_property_bar("Right Trigger Strength", Input.get_action_strength("rt"), 4)
	
