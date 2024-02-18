extends CharacterBody2D

@onready var SPEED: float = 300.0
var direction
@onready var ground_hand = load("res://entities/ground_hand.tscn") as PackedScene
@onready var timer = $Timer


func _ready():
	timer.start()

func _physics_process(delta):
	move_and_slide()


func _process(delta):
	pass



func _on_timer_timeout():
	var hand_aoe = ground_hand.instantiate() as Area2D
	get_tree().current_scene.find_child("Director").add_child(hand_aoe)
	hand_aoe.global_position = global_position
