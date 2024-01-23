class_name NpcFearState
extends State

@onready var npc = $"../.."


func update(delta):
		if npc.position.distance_to(Global.player.global_position) < npc.safe_distance:
			npc.velocity = (npc.position.direction_to(Global.player.global_position)*-1) * npc.speed
		else:
			transition.emit("NpcIdleState")
