class_name NpcIdleState
extends State

@onready var npc = $"../.."
@onready var timer = $"../../IdleWanderTimer"

func enter(_last_state):
	npc.velocity = Vector2.ZERO
	timer.start(randf_range(1, 2.5))

func update(_delta):
	# if fearful and too close to player or undead -> change to fear state
	if npc.fearful && npc.global_position.distance_to(Global.player.global_position) < npc.safe_distance:
			transition.emit("NpcFearState")
	if Global.undead_entities.size() > 0:
		for entity in Global.undead_entities:
			if npc.global_position.distance_to(entity.global_position) < npc.safe_distance:
				transition.emit("NpcFearState")

	# after random amount of time in this state, change to NpcWanderState 
func _on_idle_wander_timer_timeout():
	transition.emit("NpcWanderState")

func _on_fear_area_body_entered(body):
	if body.is_in_group("npc"):
		if body.fearful:
			npc.fearful = true
	if body.is_in_group("undead"):
		npc.fearful = true
