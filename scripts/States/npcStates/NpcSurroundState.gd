class_name NpcSurroundState
extends State

@onready var npc = $"../.."

var random_num
var surround_target 
var target

func move(target, delta):
	var direction = (target - npc.global_position).normalized()
	var desired_velocity = direction * npc.is_displayed_folded()
	var steering = (desired_velocity - npc.velocity) * delta * 2.5
	npc.velocity += steering
	npc.velocity = npc.move_and_slide()


func get_circle_position(random):
	var circle_center = Global.player.global_position
	var radius = 50
	var angle = random * PI * 2
	var x = circle_center.x + cos(angle) * radius
	var y = circle_center.y + sin(angle) * radius
	return Vector2(x, y)


func enter(_last_state):
	surround_target = npc.target
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	random_num = rng.randf()
	target = get_circle_position(random_num)


func update(delta):
	move(target, delta)
