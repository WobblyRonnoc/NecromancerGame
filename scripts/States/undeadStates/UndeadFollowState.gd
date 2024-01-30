class_name UndeadFollowState
extends State

@onready var undead = $"../.."

var random_num
var target
var radius = 100

func move(target, delta):
	var direction = (target - undead.global_position).normalized()
	var desired_velocity = direction * undead.speed
	var steering = (desired_velocity - undead.velocity) * delta * 2.5
	undead.velocity += steering
	undead.move_and_slide()


func get_circle_position(random):
	var circle_center = undead.target.global_position
	var angle = random * PI * 2
	var x = circle_center.x + cos(angle) * radius
	var y = circle_center.y + sin(angle) * radius
	return Vector2(x, y)


func enter(_last_state):
	undead.target = Global.player
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	random_num = rng.randf()


func update(delta):
	target = get_circle_position(random_num)
	move(target, delta)


func _on_aggro_area_body_entered(body):
	if body.is_in_group("npc"):
		undead.target = body.get_parent()
		transition.emit("UndeadSurroundState")
