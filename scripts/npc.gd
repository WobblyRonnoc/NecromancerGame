class_name Npc
extends CharacterBody2D


@onready var player = $"../Player" # player info needs to not be hard coded
@onready var target = player.global_position

@export var speed = 75

@export var safe_distance : float = 300.0
@onready var fear_area = $FearArea/CollisionShape2D

@onready var npc_state_machine = $NpcStateMachine


var move_direction
var wander_time
var idle_time

func _ready():
	if Global.dev_mode:
		position = get_global_mouse_position()
		
	speed = randf_range(75, 150)
	fear_area.shape.set_radius(safe_distance)

func run():
	if position.distance_to(target) < safe_distance:
		velocity = (position.direction_to(target)*-1) * speed
		
func _process(delta):
	move_and_slide()

func _on_fear_area_entered(area):
	if area.is_in_group("terror_area"):
		pass

