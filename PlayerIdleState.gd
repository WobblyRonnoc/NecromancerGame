class_name PlayerIdleState
extends State

func listen_for_casting_input():
	if Input.get_action_strength("rt") != 0.0:
		Global.player.raise_hand("right")
		transition.emit("PlayerWeaveState")


func update(delta):
	Global.player.move()

