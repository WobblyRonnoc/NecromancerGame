class_name UndeadStateMachine

extends Node

@export var CURRENT_STATE : State
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible child node")
		
	CURRENT_STATE.enter(CURRENT_STATE.name) # first time entered just passing the same state

func _process(delta):
	CURRENT_STATE.update(delta)

func _physics_process(delta):
	CURRENT_STATE.physics_update(delta)

func on_child_transition(new_state_name : StringName) -> void:
	var new_state = states.get(new_state_name)
	var last_state = states.get(CURRENT_STATE)
	if new_state != null:
		if new_state != CURRENT_STATE:
			CURRENT_STATE.exit(new_state)
			new_state.enter(last_state)
			CURRENT_STATE = new_state
		elif new_state == CURRENT_STATE:
			pass
		else:
			push_warning("State does not exist")
			
