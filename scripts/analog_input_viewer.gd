extends Node2D

const id_values : Dictionary = {"up": 1, "right": 2, "down": 3, "left": 4}

@onready var line = $Line
var travelling = false

@export var radius : float = 50
@onready var id_coords : Dictionary = {"up": Vector2(0, -radius), "right": Vector2(radius, 0), "down": Vector2(0, radius), "left": Vector2(-radius, 0)}
@onready var analog = $AnalogPosition
@onready var back = $back
@onready var analog_vector

func _ready():
	Global.wheel_ui = self

func create_line():
		line.add_point(analog.position)

func _process(delta):
	if travelling && visible:
		create_line()
	if line.get_point_count() > 2000:
		line.clear_points()
		
	analog_vector = Input.get_vector("rs_left","rs_right","rs_up","rs_down",-1.0)
	
	# limit the input display's position to the radius 
	analog.position = analog_vector * radius
	analog.position.clamp(position, analog_vector * radius)
	

func reset_selection():
	# Clear and reset for next cast
	for child in get_children():
		if child.name.contains("SpellPoint"):
			child.selected = false
	line.clear_points()

func _on_area_2d_area_entered(area):
	if area.is_in_group("spell_point") && visible:
		create_line()
		travelling = false


func _on_area_2d_area_exited(area):
	if area.is_in_group("spell_point") && visible:
		create_line()
		travelling = true

