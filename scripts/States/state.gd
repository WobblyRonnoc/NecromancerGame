class_name State

extends Node

signal transition(new_state_name: StringName)

func enter(_last_state) -> void:
	pass

func exit(_new_state) -> void:
	pass

func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
	
