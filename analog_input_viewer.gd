extends Node2D

enum side {right, left}
@export var stick: side
@onready var debug_panel = $"../DebugPanel"

const id_values : Dictionary = {"up": 1, "right": 2, "down": 3, "left": 4}

@export var radius : float = 50
@onready var id_coords : Dictionary = {"up": Vector2(0, -radius), "right": Vector2(radius, 0), "down": Vector2(0, radius), "left": Vector2(-radius, 0)}
@onready var analog = $AnalogPosition
@onready var back = $back
@onready var analog_vector
@onready var control = $"../Control"

func _ready():
	control.connect("returned_to_center", returned_to_center)
	for child in get_children():
		if child.name.contains("SpellPoint"):
			#FIXME: THIS MAY BE A BAD IDEA
			child.stick = stick # carry the side down to the points
			
			if child.key_value == 0:
				child.connect("returned_to_center", returned_to_center)
				
		
func _process(delta):
	if stick == 0:
		Global.l_analog_position = analog.position
		Global.l_analog_angle = rad_to_deg(back.position.angle_to(analog.position))
	if stick == 1:
		Global.r_analog_position = analog.position
		Global.r_analog_angle = rad_to_deg(back.position.angle_to(analog.position))
	
	if stick == 0:
		analog_vector = Input.get_vector("ls_left","ls_right","ls_up","ls_down",-1.0)
	if stick == 1:
		analog_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
		
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)

func returned_to_center(side):
	if side == 0:
		print("Left Spell: ", Global.left_spell_key)
		debug_panel.add_debug_label("Left Spell Key: ", str(Global.left_spell_key))
		Global.left_spell_key.clear()
	else:
		print("Right Spell: ", Global.right_spell_key)
		debug_panel.add_debug_label("Right Spell Key: ", str(Global.right_spell_key))
		Global.right_spell_key.clear()
		
	for child in get_children():
		if child.name.contains("SpellPoint"):
			child.selected = false


