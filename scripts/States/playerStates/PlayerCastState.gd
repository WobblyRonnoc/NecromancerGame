class_name PlayerCastState
extends State

var cursor
var undead = load("res://npc.tscn")

func cast(spell_id):
	Global.wheel_ui.line.clear_points()
	var spell_cast
	# Check cast against spells
	if Global.validate_spell(spell_id):
		Global.debug2.add_property("Spell Cast", spell_cast, 0)
			
func enter(_last_state):
		print(Global.spell_key)
		cursor = Global.cursor
		if Global.spell_key == [4,3,2,1,0]:
			cursor.show()
			cursor.global_position = Global.player.global_position * Vector2(1.2,1)
		print("Cast Success!")
		Global.debug.add_property("Current Spell", Global.SPELL_LIST[Global.formated_spell_id()], 1)

func exit(_new_state):
	cursor = Global.cursor
	get_tree().current_scene.find_child("Director").spawn_npc(undead)
	cursor.hide()
	
func update(_delta):
	cursor.global_position.x +=  Input.get_axis("rs_left","rs_right") * 3
	cursor.global_position.y +=  Input.get_axis("rs_up","rs_down") *3
	
	if Input.is_action_just_pressed("rt"):
		transition.emit("PlayerIdleState")
		
