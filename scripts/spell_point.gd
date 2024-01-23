class_name SpellPoint
extends Area2D

@export var key_value : int
var stick
@export var selected_scale : float = 1.5
@export var default_scale : float = 0.7
var selected : bool = false

func _process(_delta):
	if selected:
		scale = Vector2(selected_scale, selected_scale)
	else:
		scale = Vector2(default_scale, default_scale)

# Indicate selection by increasing size
func _on_area_entered(area):
	if area.is_in_group("analog_position") && not selected:
		selected = true
		
		Global.spell_key.append(key_value)

