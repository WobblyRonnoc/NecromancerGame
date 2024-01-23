class_name Npc
extends CharacterBody2D

@onready var state_label = $StateLabel

@onready var player = $"../Player" # player info needs to not be hard coded
@onready var target = player.global_position

@export var speed = 75

@export var safe_distance : float = 300.0
@onready var fear_area = $FearArea/CollisionShape2D

@onready var npc_state_machine = $NpcStateMachine
@onready var npc_idle_state = $NpcStateMachine/NpcIdleState
@onready var npc_wander_state = $NpcStateMachine/NpcWanderState



var move_direction
var wander_time
var idle_time

func _ready():
	if Global.dev_mode:
		position = get_global_mouse_position()
		
	speed = randf_range(75, 150)
	
func _process(delta):
	state_label.text = npc_state_machine.CURRENT_STATE.name
	move_and_slide()
