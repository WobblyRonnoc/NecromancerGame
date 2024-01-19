extends Node

const AITEST = "res://Level Scenes/aitest.tscn"
const LEVEL = "res://Level Scenes/level.tscn"

func _process(delta):
	if Input.is_key_pressed(KEY_1):
		get_tree().change_scene_to_file(LEVEL)
	
	if Input.is_key_pressed(KEY_2):
		get_tree().change_scene_to_file(AITEST)
	
