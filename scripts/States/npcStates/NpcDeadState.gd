class_name NpcDeadState
extends State

@onready var npc = $"../.."

func enter(_last_state):
	npc.set_rotation_degrees(90)
	npc.speed = 0
	
