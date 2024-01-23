class_name PlayerWeaveState
extends State

var spell_id

func validate_spell(spell_id: Array):
	var spell = str("".join(spell_id).lstrip("[").rstrip("],")) 
	var spell_cast
	# Check cast against spells
	for key in Global.SPELL_LIST:
		if key == spell:
			print(Global.SPELL_LIST[spell])
			return true
	# if the loop finds no valid spell return false
	return false


func enter():
	Global.player.emit_terror(true)

func exit():
	Global.validate_spell(spell_id)
	Global.player.emit_terror(false)


func is_trigger_pulled():
	var amount
	var trigger_pulled
	# get stick to measure action strength of
	amount = Input.get_action_strength("rt")
		
	# measure and return true if it is pulled
	if amount > 0.0:
		trigger_pulled = true
	elif amount < 1.0:
		trigger_pulled = false
		
	return trigger_pulled


func update(delta):
	# check if casting
	if is_trigger_pulled():
		Global.wheel_ui.show()
	else:
		transition.emit("PlayerCastState")
		

	
	if Input.get_action_strength("lt") != 0.0:
		Global.player.raise_hand("left")
		
	if Input.get_action_strength("rt") != 0.0:
		Global.player.raise_hand("right")
		
	if Input.get_action_strength("lt") == 0.0 && Input.get_action_strength("rt") == 0.0:
		transition.emit("")
