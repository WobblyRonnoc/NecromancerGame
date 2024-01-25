extends Node2D

var player_position
var player
var npc = load("res://npc.tscn")

var npcs : Array = []

func _ready():
	for child in get_children():
		if child.name == "Player":
			player = child
			player_position = player.global_position
	
func get_player_state() -> String:
	return player.state_machine.CURRENT_STATE.name


func get_npc_state(npc_id : int) -> String:
	return npcs[npc_id].state_machine.CURRENT_STATE.name


func debug_all_npc_states(): 
	var i = 0
	for x in npcs:
		Global.debug2.add_property("npc %d" % i, get_npc_state(i), i+1)
		i+=1

func force_state(new_state : String, target: Node):
	target.state_machine.CURRENT_STATE.transition.emit(new_state)

# use the signal instead of forcing to avoid constantly overriding
func npc_fear_check(entity):
	if entity.position.distance_to(player.position) < entity.safe_distance:
		entity.state_machine.CURRENT_STATE.transition.emit("NpcFearState")


func spawn_npc(entity : PackedScene):
	var x = npc.instantiate()
	add_child(x,true)
	

func _process(delta):
	Global.debug2.add_property("player state", get_player_state(), 0)
	if get_player_state() != "PlayerIdleState":
		for entity in get_tree().get_nodes_in_group("npc"):
			npc_fear_check(entity)
	debug_all_npc_states()
	
	# if player is not in idle state -> check if all npc's distance_to(player.global_position) > safe_distance
	#if not: each npc too close to player transitions to fear state
	
	if player:
		player_position = player.global_position

	if Input.is_action_just_pressed("left_click"):
		spawn_npc(npc)
	
