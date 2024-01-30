class_name PlayerIdleState
extends State

func listen_for_casting_input():
	if Global.is_trigger_pulled():
		transition.emit("PlayerWeaveState")

func enter(_last_state):
	if Global.player:
		Global.player.emit_terror(false)
		Global.spell_key.clear()

func update(_delta):
	if Input.is_action_just_pressed("rt"):
		transition.emit("PlayerCommandState")
	Global.player.move()
	listen_for_casting_input()

