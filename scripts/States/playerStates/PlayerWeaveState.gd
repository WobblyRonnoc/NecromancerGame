class_name PlayerWeaveState
extends State


func enter(_last_state):
	Global.spell_key = []
	Global.player.emit_terror(true)
	Global.wheel_ui.show()
	Global.wheel_ui.reset_selection()

func exit(_new_state):
	Global.wheel_ui.hide()
	Global.wheel_ui.reset_selection()
	
func update(_delta):
	Global.player.move()
	Global.debug.add_property("Current Spell", Global.spell_key, 1)
	if !Global.is_trigger_pulled():
		if Global.validate_spell(Global.spell_key):
			transition.emit("PlayerCastState")
		else:
			transition.emit("PlayerIdleState")
