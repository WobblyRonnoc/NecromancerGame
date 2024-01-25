class_name NpcWanderState
extends State


@onready var npc = $"../.."

func enter():
	randomize_wander()
	
	
func physics_update(delta):
	npc.velocity = npc.move_direction * npc.speed
	
	
func update(delta):
	if npc.wander_time > 0.0:
		npc.wander_time -= delta
	else:
		randomize_wander()
		
func randomize_wander():
	if randf() > 0.5:
		npc.move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		npc.wander_time = randf_range(1, 3)
		npc.idle_time = randf_range(1, 3)
	else:
		transition.emit("NpcIdleState")
