class_name PlayerCastState
extends State

var cursor
var undead = load("res://entities/undead.tscn")

func enter(_last_state):
	Global.wheel_ui.line.clear_points()
	if Global.validate_spell(Global.spell_key):
		cursor = Global.cursor
		cursor.show()
		cursor.position = Global.player.global_position
			
	#DEBUG 
	print(Global.spell_key)
	print("Cast Success!")
	Global.debug.add_property("Current Spell", Global.SPELL_LIST[Global.formated_spell_id()], 1)

func exit(_new_state):
	cursor = Global.cursor
	get_tree().current_scene.find_child("Director").spawn_npc(undead)
	cursor.hide()
	Global.player.right_hand.hide()
	
func update(_delta):
	Global.player.raise_hand()
	cursor.global_position.x +=  Input.get_axis("rs_left","rs_right") * 3
	cursor.global_position.y +=  Input.get_axis("rs_up","rs_down") *3
	
	if Input.is_action_just_pressed("rt"):
		transition.emit("PlayerIdleState")
		
