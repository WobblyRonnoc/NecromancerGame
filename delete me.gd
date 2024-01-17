extends Node2D
var x = 0
var spell = [1,2,0]
enum STATES {
	pressed,
	released,
	idle
}
var current_state = STATES.idle

func transition(new_state, callback : Callable):
	callback.call()
	current_state = new_state
	
func show_wheel():
	print("wheel")
	
func _process(delta):
	Global.debug.add_property_bar("trigger strength", Input.get_action_strength("rt"), 0)
	if current_state == STATES.idle:
		Global.debug.add_property("output", "Idle", 1)
		if Input.get_action_strength("rt") > 0.0:
			transition(STATES.pressed, func(): print("wheel"))
		
	if current_state == STATES.pressed:
		Global.debug.add_property("output", "Wheel UI!", 1)
		if Input.get_action_strength("rt") < 1.0:
			transition(STATES.released, func(cast): print(str(cast)))
	
	if current_state == STATES.released:
		Global.debug.add_property("output", "Casting!", 1)
		current_state = STATES.idle
