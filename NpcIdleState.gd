class_name NpcIdleState
extends State

@onready var npc = $"../.."
@onready var timer = $"../../IdleWanderTimer"

func enter():
	npc.velocity = Vector2.ZERO
	timer.start(randf_range(1, 2.5))


	# after random amount of time in this state, change to NpcWanderState 
func _on_idle_wander_timer_timeout():
	transition.emit("NpcWanderState")
