extends Node

var dev_mode = true 

@onready var player
@onready var wheel_ui

var debug
var debug2 

var spell

var r_analog_angle = 0.0
var r_analog_position = Vector2.ZERO

var right_spell_key : Array = []

const SPELL_LIST : Dictionary = {
	"120" : "Fire Ball",
	"1230": "Buff AoE",
	"103" : "Rend Flesh",
	"14023" : "Line AoE",
	"41230" : "Sheild",
	"43210" : "Summon Undead"
	}

func validate_spell(spell_id: Array):
	spell = str("".join(spell_id).lstrip("[").rstrip("],")) 
	# Check cast against spells
	for key in SPELL_LIST:
		if key == spell:
			print(SPELL_LIST[spell])
			return true
	# if the loop finds no valid spell return false
	return false
	

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("zoom_in"):
		get_tree().get_current_scene().get_child(0).camera_zoom *= 1.05
	if Input.is_action_just_pressed("zoom_out"):
		get_tree().get_current_scene().get_child(0).camera_zoom *= 0.95
	
	if get_tree().get_current_scene().scene_file_path == Scenes.LEVEL:
		debug.add_property("Queued [RIGHT] Spell ID", right_spell_key, 3)
