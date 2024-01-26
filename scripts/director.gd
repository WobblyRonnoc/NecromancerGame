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
	
func get_player_state() -> StringName:
	return player.state_machine.CURRENT_STATE.name


func get_npc_state(npc_id : int) -> StringName:
	return npcs[npc_id].state_machine.CURRENT_STATE.name


func debug_all_npc_states(): 
	var i = 0
	for x in npcs:
		Global.debug2.add_property("npc %d" % i, get_npc_state(i), i+1)
		i+=1

func force_state(new_state : String, target: Node):
	target.state_machine.CURRENT_STATE.transition.emit(new_state)

# run away if fearful or player is casting stuff


func spawn_npc(entity : PackedScene):
	var x = entity.instantiate()
	add_child(x,true)
	

func _process(delta):
	Global.debug2.add_property("player state", get_player_state(), 0)
	for child in get_children():
		if child.is_in_group("npc"):
			if child.position.distance_to(player.position) < child.safe_distance:
				if child.fearful == true || get_player_state() != "PlayerIdleState":
					child.state_machine.CURRENT_STATE.transition.emit("NpcFearState")
				
	debug_all_npc_states()
	

	if player:
		player_position = player.global_position

	if Input.is_action_just_pressed("left_click"):
		spawn_npc(npc)
	
