class_name PlayerIdleState
extends State

func listen_for_casting_input():
	if Global.is_trigger_pulled():
		transition.emit("PlayerWeaveState")

func enter(_last_state):
	if Global.player:
		Global.player.sprite.play("Idle")
		#Global.player.emit_terror(false)
		Global.spell_key.clear()
		if _last_state == Global.player.state_machine.states["PlayerWeaveState"]:
			Global.player.sprite.play_backwards("UseHand")
			Global.player.animated_hand.hide()
		if _last_state == Global.player.state_machine.states["PlayerCastState"]:
			Global.player.sprite.play_backwards("UseHand")
			Global.player.animated_hand.hide()



func exit(_new_state):
	new_state = _new_state
	
func update(_delta):
	if Input.is_action_just_pressed("rt"):
		transition.emit("PlayerCommandState")
	Global.player.move()
	listen_for_casting_input()

