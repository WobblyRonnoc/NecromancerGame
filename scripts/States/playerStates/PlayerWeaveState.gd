class_name PlayerWeaveState
extends State


func enter(_last_state):
	
	Global.spell_key = []
	Global.wheel_ui.show()
	Global.wheel_ui.reset_selection()
	#show arm and cloak anim
	Global.player.sprite.play("UseHand")
	Global.player.animated_hand.show()


func exit(_new_state):
	if _new_state == Global.player.state_machine.states["PlayerIdleState"]:
		Global.player.sprite.play_backwards("UseHand")
		Global.player.animated_hand.hide()
	Global.wheel_ui.hide()
	Global.wheel_ui.reset_selection()
	Global.player.right_hand.hide()


	
func update(_delta):
	Global.player.raise_hand()
	Global.player.move()
	if !Global.is_trigger_pulled():
		if Global.validate_spell(Global.spell_key):
			transition.emit("PlayerCastState")
		else:
			transition.emit("PlayerIdleState")

	#DEBUG
	Global.debug.add_property("Current Spell", Global.spell_key, 1)
