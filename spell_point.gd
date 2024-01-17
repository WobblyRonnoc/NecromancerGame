class_name SpellPoint
extends MeshInstance2D

@export var key_value : int
var stick
var selected_scale = Vector2(20.0,20.0)
var default_scale = Vector2(10.0,10.0)
var selected : bool = false

func _process(_delta):
	if selected:
		scale = selected_scale
	else:
		scale = default_scale

# Indicate selection by increasing size
func _on_area_2d_area_entered(area):
	if area.is_in_group("analog_position") && not selected && get_parent().is_visible():
		selected = true
		if stick == 0: 
			Global.left_spell_key.append(key_value)
		if stick == 1:
			Global.right_spell_key.append(key_value)

# add the selection value to the global key array
func _on_area_2d_area_exited(area):
	pass
		
