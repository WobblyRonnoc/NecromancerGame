extends Node

var undead = load("res://entities/undead.tscn")

func summon(entity):
	get_tree().current_scene.find_child("Director").spawn_npc(entity)

func cast(spell_key):
	# make a custom JSON resource to save spell info
	
	if spell_key == [3, 0]:
		summon(undead)
