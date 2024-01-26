class_name NpcIdleState
extends State

@onready var npc = $"../.."
@onready var timer = $"../../IdleWanderTimer"

func enter(_last_state):
	npc.velocity = Vector2.ZERO
	timer.start(randf_range(1, 2.5))

func update(_delta):
	if npc.fearful && npc.global_position.distance_to(Global.player.global_position) < npc.safe_distance:
		transition.emit("NpcFearState")

	# after random amount of time in this state, change to NpcWanderState 
func _on_idle_wander_timer_timeout():
	transition.emit("NpcWanderState")


func _on_fear_area_area_entered(area):
	if area.is_in_group("npc"):
		if area.get_parent().fearful == true:
			npc.fearful = true


func _on_fear_area_body_entered(body):
	if body.is_in_group("npc"):
		if body.fearful:
			npc.fearful = true
