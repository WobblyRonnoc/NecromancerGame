class_name NpcFearState
extends State

@onready var npc = $"../.."

func enter():
	for child in npc.get_children():
		if child.name.contains("AnimatedSprite"):
			child.show()
			npc.set_modulate(Color(0.463, 1, 0.561))

func exit():
	for child in npc.get_children():
		if child.name.contains("AnimatedSprite"):
			child.hide()
			npc.set_modulate(Color(1,1,1,1))

func update(delta):
		print(npc.position.distance_to(Global.player.position))
		if npc.global_position.distance_to(Global.player.global_position) < npc.safe_distance:
			npc.velocity = (npc.position.direction_to(Global.player.global_position)*-1) * npc.speed
		else:
			transition.emit("NpcIdleState")
