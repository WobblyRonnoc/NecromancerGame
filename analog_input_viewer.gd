extends Node2D

enum side {left, right}
@export var stick: side
const id_values : Dictionary = {"up": 1, "right": 2, "down": 3, "left": 4}

@export var radius : float = 50
@onready var id_coords : Dictionary = {"up": Vector2(0, -radius), "right": Vector2(radius, 0), "down": Vector2(0, radius), "left": Vector2(-radius, 0)}
@onready var analog = $AnalogPosition
@onready var back = $back
@onready var analog_vector

var trigger_pulled : bool = false
var has_cast : bool = false

func trigger_depth():
	if stick == 0:
		return Input.get_action_strength("lt")
	if stick == 1:
		return Input.get_action_strength("rt")
	

func _ready():
	for child in get_children():
		if child.name.contains("SpellPoint"):
			#FIXME: THIS MAY BE A BAD IDEA
			child.stick = stick # carry the side down to the points
		
func _process(delta):
	Global.debug.add_property("Queued [LEFT] Spell ID", Global.left_spell_key, 0)
	#Global.debug.add_property_bar("[LEFT]Trigger Strength", Input.get_action_strength("lt"), 1)
	
	Global.debug.add_property("Queued [RIGHT] Spell ID", Global.right_spell_key, 3)
	#Global.debug.add_property_bar("Right Trigger Strength", Input.get_action_strength("rt"), 4)
	
	if stick == 0:
		analog_vector = Input.get_vector("ls_left","ls_right","ls_up","ls_down",-1.0)
	else:
		analog_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
		
	if trigger_depth() > 0.0:
		trigger_pulled = true
	elif trigger_depth() < 1.0:
		trigger_pulled = false
		
	if trigger_pulled:
		has_cast = false
		show()
	elif !has_cast:
		cast(stick, Global.get_spell_key(stick))
		
			

	# limit the input display's position to the radius 
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)
	
	
func cast(stick, spell_id):
	has_cast = true
	
	# format key for spell list query
	var spell = str("".join(spell_id).lstrip("[").rstrip("],")) 
	var spell_cast
	# Check cast against spells
	for key in Global.SPELL_LIST:
		if key == spell:
			spell_cast = Global.SPELL_LIST[spell]
			Global.debug2.add_property("Spell Cast", spell_cast, 0)
			break
		else:
			spell_cast = ""
			Global.debug2.add_property("Spell Cast", spell_cast, 0)
			# emit a cast signal here so things know what to do!
			
	# Clear and reset for next cast
	for child in get_children():
		if child.name.contains("SpellPoint"):
			child.selected = false
	

	if stick == 0:
		Global.debug.add_property("[LEFT] Cast Spell ID", spell, 1)
		Global.left_spell_key.clear()
		hide()
	if stick == 1:
		Global.debug.add_property("[RIGHT] Cast Spell ID", spell, 4)
		Global.right_spell_key.clear()
		hide()
		

	
	
	


