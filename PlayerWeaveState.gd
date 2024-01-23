class_name PlayerWeaveState
extends State


func enter():
	Global.player.emit_terror(true)
	Global.wheel_ui.show()
	Global.wheel_ui.reset_selection()

func exit():
	Global.wheel_ui.hide()
	Global.wheel_ui.reset_selection()
	
func update(delta):
	Global.player.move()
	Global.debug.add_property("Current Spell", Global.spell_key, 1)
	if !Global.is_trigger_pulled():
		if Global.validate_spell(Global.spell_key):
			transition.emit("PlayerCastState")
		else:
			transition.emit("PlayerIdleState")
