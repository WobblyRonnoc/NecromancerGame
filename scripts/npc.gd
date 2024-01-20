class_name Npc

extends CharacterBody2D
@onready var player = $"../Player" # player info needs to not be hard coded

@onready var target = player.global_position
var speed = 75
@export var safe_distance : float = 300.0
@onready var fear_area = $FearArea/CollisionShape2D

enum STATES {
	IDLE,
	FOLLOW,
	RUN,
	SURROUND,
	WANDER,
	MOVE_TO
}
var current_state = STATES.IDLE
@onready var anim = $AnimatedSprite2D
@onready var anim2 = $AnimatedSprite2D2

func _ready():
	if Global.dev_mode:
		position = get_global_mouse_position()
		
	speed = randf_range(75, 150)
	fear_area.shape.set_radius(safe_distance)

func idle():
	velocity = Vector2.ZERO

func follow():
	velocity = position.direction_to(target) * speed


func run():
	if position.distance_to(target) < safe_distance:
		velocity = (position.direction_to(target)*-1) * speed
	else:
		current_state = STATES.IDLE
		
func surround():
	pass
	
func wander():
	pass

func get_current_state(current_state):
	if current_state == STATES.IDLE:
		idle()
	if current_state == STATES.FOLLOW:
		follow()
	if current_state == STATES.RUN:
		run()
	if current_state == STATES.SURROUND:
		surround()
	if current_state == STATES.WANDER:
		wander()
	
func _process(delta):
	if current_state == STATES.RUN:
		anim.show()
		anim2.show()
	else:
		anim.hide()
		anim2.hide()
	target = player.global_position
	get_current_state(current_state)
	
	Global.debug.add_property("Current State", STATES.find_key(current_state), 0)
	move_and_slide()

func _on_fear_area_entered(area):
	if area.is_in_group("terror_area"):
		current_state = STATES.RUN

