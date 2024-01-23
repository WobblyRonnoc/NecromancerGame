extends Node2D

var player_position
var player
var npc = preload("res://npc.tscn")

var npcs : Array = []

func _ready():
	for child in get_children():
		if child.name == "Player".to_lower():
			player = child
			player_position = player.global_position
		if child.is_in_group("npc"):
			npcs.append(child)
	
func _process(delta):
	#TODO: GET EXPLICIT REF TO ALL CHILDREN'S CURRENT STATE
	# if player is not in idle state -> check if all npc's distance_to(player.global_position) > safe_distance
	#if not: each npc too close to player transitions to fear state
	if player:
		player_position = player.global_position

	if Input.is_action_just_pressed("left_click"):
		var x = npc.instantiate()
		add_child(x)
	
	
