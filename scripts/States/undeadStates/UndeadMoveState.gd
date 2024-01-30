class_name UndeadMoveState
extends State

@onready var undead = $"../.."

func update(_delta):
	undead.manual_move()
