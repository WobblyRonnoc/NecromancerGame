class_name Npc
extends CharacterBody2D

@onready var state_machine = $NpcStateMachine

@onready var player = $"../Player" # player info needs to not be hard coded
@onready var target = player.global_position

@export var speed = 75

@export var safe_distance : float = 150.0
@onready var fear_area = $FearArea/CollisionShape2D

@onready var state_label = $StateLabel


var wander_direction
var wander_time
var idle_time

var fearful = false
var is_dead

func _ready():
	position = get_global_mouse_position()
	speed = randf_range(75, 150)
	
func _process(delta):
	if fearful:
		set_modulate(Color(0.3,1,0.5,1))
	else:
		set_modulate(Color(1,1,1,1))
	state_label.text = state_machine.CURRENT_STATE.name + " fearful: " + str(fearful)
	move_and_slide()
