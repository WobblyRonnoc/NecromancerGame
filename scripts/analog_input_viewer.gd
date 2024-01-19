extends Node2D

enum side {left, right}
@export var stick: side
const id_values : Dictionary = {"up": 1, "right": 2, "down": 3, "left": 4}

@onready var line = $Line
var travelling = false

@export var radius : float = 50
@onready var id_coords : Dictionary = {"up": Vector2(0, -radius), "right": Vector2(radius, 0), "down": Vector2(0, radius), "left": Vector2(-radius, 0)}
@onready var analog = $AnalogPosition
@onready var back = $back
@onready var analog_vector

@onready var reset_timer = $ResetTimer
var has_cast : bool = false

var is_casting : bool = false


func is_trigger_pulled():
	var amount
	var trigger_pulled
	# get stick to measure action strength of
	if stick == 0:
		amount = Input.get_action_strength("lt") 
	if stick == 1:
		amount = Input.get_action_strength("rt")
		
	# measure and return true if it is pulled
	if amount > 0.0:
		trigger_pulled = true
	elif amount < 1.0:
		trigger_pulled = false
		
	return trigger_pulled

func _ready():
	for child in get_children():
		if child.name.contains("SpellPoint"):
			child.stick = stick # carry the side down to the points


func _process(delta):
	if travelling && visible:
		if line.get_point_count() > 2000:
			line.clear_points()	
		line.add_point(analog.position)
		
	if stick == 0:
		analog_vector = Input.get_vector("ls_left","ls_right","ls_up","ls_down",-1.0)
	else:
		analog_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
		
	# limit the input display's position to the radius 
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)
	
	# check if casting
	if is_trigger_pulled():
		has_cast = false
		is_casting = true
		show()
	elif !has_cast:
		cast(stick, Global.get_spell_key(stick))


func cast(stick, spell_id):
	has_cast = true
	is_casting = false
	line.clear_points()
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
		


func _on_area_2d_area_entered(area):
	if area.is_in_group("spell_point") && visible:
		line.add_point(analog.position)
		travelling = false
		


func _on_area_2d_area_exited(area):
	if area.is_in_group("spell_point") && visible:
		line.add_point(analog.position)
		travelling = true
		reset_timer.start()


func _on_reset_timer_timeout():
	Global.clear_spell_key(stick)
