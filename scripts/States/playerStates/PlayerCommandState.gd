class_name PlayerCommandState
extends State

@onready var player = $"../.."

func update(_delta):
	player.raise_hand()
	if Input.is_action_just_released("rt"):
		transition.emit("PlayerIdleState")
		#player.right_hand.hide()
