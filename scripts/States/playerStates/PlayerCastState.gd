class_name PlayerCastState
extends State


func cast(spell_id):
	Global.wheel_ui.line.clear_points()
	var spell_cast
	# Check cast against spells
	if Global.validate_spell(spell_id):
		Global.debug2.add_property("Spell Cast", spell_cast, 0)
			
func enter(_last_state):
	print("Cast Success!")
	Global.debug.add_property("Current Spell", Global.SPELL_LIST[Global.formated_spell_id()], 1)

func update(_delta):
	if Input.is_action_just_pressed("rt"):
		transition.emit("PlayerIdleState")
		
