extends Node

var dev_mode = true 

@onready var player
@onready var wheel_ui

var debug
var debug2 

var r_analog_angle = 0.0
var r_analog_position = Vector2.ZERO

var spell_key : Array = []

const SPELL_LIST : Dictionary = {
	"120" : "Fire Ball",
	"1230": "Buff AoE",
	"103" : "Rend Flesh",
	"14023" : "Line AoE",
	"41230" : "Sheild",
	"43210" : "Summon Undead"
	}

#UTILITY FUNCTIONS (move to seperate global later!!)
func formated_spell_id():
	return str("".join(spell_key).lstrip("[").rstrip("],")) 

func validate_spell(spell_id: Array):
	var spell = str("".join(spell_id).lstrip("[").rstrip("],")) 
	# Check cast against spells
	for key in SPELL_LIST:
		if key == spell:
			print(SPELL_LIST[spell])
			return true
	# if the loop finds no valid spell return false
	return false
	
func is_trigger_pulled():
	var amount
	var trigger_pulled
	# get stick to measure action strength of
	amount = Input.get_action_strength("lt")
		
	# measure and return true if it is pulled
	if amount > 0.0:
		trigger_pulled = true
	elif amount < 1.0:
		trigger_pulled = false
		
	return trigger_pulled

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("zoom_in"):
		get_tree().get_current_scene().get_child(0).camera_zoom *= 1.05
	if Input.is_action_just_pressed("zoom_out"):
		get_tree().get_current_scene().get_child(0).camera_zoom *= 0.95

	debug.add_property("Player State", player.player_state_machine.CURRENT_STATE.name,0)
