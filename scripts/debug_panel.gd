extends Control

@onready var property_container = %VBoxContainer
var label


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.debug == null:
		Global.debug = self
	else:
		Global.debug2 = self
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("clear_debug_panel"):
		clear_properties()
	if Input.is_action_just_pressed("toggle_debug_panel"):
		visible = !visible


func add_property_bar(title : String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = ProgressBar.new()
		target.max_value = 1
		target.min_value = 0
		property_container.add_child(target)
		target.add_to_group("debug")
		target.name = title
	elif visible:
		target.value = value
		property_container.move_child(target, order)
	
	

func add_property(title : String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.add_to_group("debug")
		target.name = title
		target.text = target.name + ": " + str(value)
	else: 
		if visible:
			target.text = title + ": " + str(value)
			# TODO: add sorting logic to override existing indexes
	
	
func clear_properties():
	for child in property_container.get_children():
		child.queue_free()
