class_name NpcWanderState
extends State


@onready var npc = $"../.."

func enter(_last_state):
	npc.idle_time = randf_range(1, 3)
	npc.wander_time = randf_range(1, 3)
	npc.wander_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func physics_update(_delta):
	npc.velocity = npc.wander_direction * npc.speed

func update(delta):
	if npc.fearful && npc.global_position.distance_to(Global.player.global_position) < npc.safe_distance:
		transition.emit("NpcFearState")
		
	if npc.wander_time > 0.0:
		npc.wander_time -= delta
	else:
		transition.emit("NpcIdleState")



func _on_fear_area_body_entered(body):
	if body.is_in_group("npc"):
		if body.fearful:
			npc.fearful = true
