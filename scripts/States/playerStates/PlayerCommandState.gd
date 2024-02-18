class_name PlayerCommandState
extends State

@onready var player = $"../.."

func update(_delta):
	player.raise_hand()
	if Input.is_action_just_released("rt"):
		transition.emit("PlayerIdleState")
		#player.right_hand.hide()

func enter(_last_state):
	Global.player.animated_hand.show()
	Global.player.sprite.play("UseHand")
	
func exit(_new_state):
	Global.player.sprite.play_backwards("UseHand")
	Global.player.animated_hand.hide()
