extends Node2D

var player_position
var player
var npc = preload("res://npc.tscn")


func _ready():
	for child in get_children():
		if child.name == "Player".to_lower():
			player = child
			player_position = player.global_position
			break
	
func _process(delta):
	if player:
		player_position = player.global_position
	
	if Input.is_action_just_pressed("left_click"):
		var x = npc.instantiate()
		add_child(x)
	
	
