class_name PlayerCommandState
extends State

func update(_delta):
	if Input.is_action_just_released("rt"):
		transition.emit("PlayerIdleState")
