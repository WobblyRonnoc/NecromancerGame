extends Control

@onready var label_container = %VBoxContainer
var label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("clear_debug_panel"):
		clear_labels()
	if Input.is_action_pressed("toggle_debug_panel"):
		visible = !visible

func update_label(label: Label, value):
	label.text = value
	
# FIXME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
func add_debug_label(title : String, value):
	label = Label.new()
	for child in label_container.get_children():
		if child.name == title:
			update_label(child, child.text)
	#label_container.add_child(label)
	label.name = title
	label.text = label.name + value
	
func clear_labels():
	for child in label_container.get_children():
		child.queue_free()
