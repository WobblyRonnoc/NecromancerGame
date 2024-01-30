extends CharacterBody2D

@onready var target = Global.player
@export var speed : float = 500  
@onready var director = $".."
@onready var aggro_area = $AggroArea

func _ready():
	global_position = Global.cursor.global_position
	
