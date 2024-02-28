class_name PlayerCastState
extends State

var cursor
var undead = load("res://entities/undead.tscn")
var projectile = load("res://entities/projectile.tscn") as PackedScene
var cursor_mode = false

#check if spell needs cursor
func cursor_mode_check(spell_key):
	# list any spells that need a cursor in this if statement!
	if spell_key == [3, 0]:
		cursor = Global.cursor
		cursor.show()
		cursor.position = Global.player.global_position
		cursor_mode = true

func enter(_last_state):
	Global.wheel_ui.line.clear_points()
	if Global.validate_spell(Global.spell_key):
		cursor_mode_check(Global.spell_key)
		
	#DEBUG
	Global.debug.add_property("Current Spell", Global.SPELL_LIST[Global.formated_spell_id()], 1)


func exit(_new_state):
	if cursor:
		cursor = Global.cursor
		cursor.hide()
	Global.player.right_hand.hide()
	cursor_mode = false
	
func update(_delta):
	Global.debug.add_property("spell key", Global.spell_key, 2)
	Global.player.raise_hand()
	if cursor:
		cursor.global_position.x +=  Input.get_axis("rs_left","rs_right") * 3
		cursor.global_position.y +=  Input.get_axis("rs_up","rs_down") * 3
		
	if Input.is_action_just_pressed("rt"):
		# FIXME: THIS IS HARD CODED FOR PORTFOLIO PURPOSES PLEASE FIX ASAP
		if cursor_mode:
			cast([3, 0])
		else:
			cast([1, 2, 0])
		transition.emit("PlayerIdleState")


func cast(spell_key):
	if spell_key == [3, 0]:
		get_tree().current_scene.find_child("Director").spawn_npc(undead)
		
	if spell_key == [1, 2, 0]:
		#spawn projectile at hand position - moving away from hand's origin point
		shoot()
		
	if spell_key == [1, 4, 0, 2, 3]:
		# Line AoE
		pass
		

func shoot():
	var inst = projectile.instantiate() as CharacterBody2D
	owner.add_child(inst)
	inst.global_position = Global.player.right_hand.global_position
	inst.velocity = (inst.position.direction_to(Global.player.hand_origin.position) * inst.SPEED) * -1
	
