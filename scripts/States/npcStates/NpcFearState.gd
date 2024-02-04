class_name NpcFearState
extends State

@onready var npc = $"../.."
@onready var hitbox = $"../../Hitbox"
@onready var collision = $"../../CollisionShape2D"

func enter(_last_state):
	if not npc.fearful:
		npc.fearful = true
	for child in npc.get_children():
		if child.name.contains("AnimatedSprite"):
			child.show()
			#npc.set_modulate(Color(0.463, 1, 0.561))
			npc.sprite.play()
			
func exit(_new_state):
	for child in npc.get_children():
		if child.name.contains("AnimatedSprite"):
			child.hide()
			#npc.set_modulate(Color(1,1,1,1))
			npc.sprite.stop()
			npc.sprite.frame
func update(_delta):
	# if too close to player or undead -> run away
	if npc.global_position.distance_to(Global.player.global_position) < npc.safe_distance:
		run_from(Global.player.global_position)
	elif Global.undead_entities.size() > 0:
		for entity in Global.undead_entities:
			if npc.global_position.distance_to(entity.global_position) < npc.safe_distance:
				run_from(entity.global_position)
	else:
		transition.emit("NpcIdleState")

func run_from(target : Vector2):
	npc.velocity = (npc.position.direction_to(target)*-1) * (npc.speed * 1.5)


func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("undead"):
		npc.is_dead = true
		Global.npcs.erase(self)
		hitbox.set_deferred("monitoring", false)
		hitbox.set_deferred("monitorable", false)
		collision.set_deferred("disabled", true)
		transition.emit("NpcDeadState")
