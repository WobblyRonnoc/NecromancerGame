extends Node2D
var x = 0
var spell = [1,2,0]
enum STATES {
	pressed,
	released,
	idle
}
var current_state = STATES.idle
var trigger_pulled : bool = false

func trigger_depth(action : String) -> float:
	return Input.get_action_strength(action)
	
func _process(delta):
	Global.debug.add_property_bar("trigger strength", trigger_depth("rt"), 0)
	
	if trigger_depth("rt") > 0.0:
		trigger_pulled = true
	elif trigger_depth("rt") < 1.0:
		trigger_pulled = false
		
	
