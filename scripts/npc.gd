class_name Npc
extends CharacterBody2D

@onready var state_machine = $NpcStateMachine

@onready var player = $"../Player" # player info needs to not be hard coded
@onready var target = player.global_position

@export var speed = 75

@export var safe_distance : float = 300.0
@onready var fear_area = $FearArea/CollisionShape2D

@onready var state_label = $StateLabel


var move_direction
var wander_time
var idle_time

func _ready():
	if Global.dev_mode:
		position = get_global_mouse_position()
		
	speed = randf_range(75, 150)
	
func _process(delta):
	state_label.text = state_machine.CURRENT_STATE.name
	move_and_slide()
