class_name UndeadSurroundState
extends State

@onready var undead = $"../.."

var random_num
var radius

func move(target, delta):
	var direction = (target - undead.global_position).normalized()
	var desired_velocity = direction * undead.speed
	var steering = (desired_velocity - undead.velocity) * delta * 2.5
	undead.velocity += steering
	undead.move_and_slide()


func get_circle_position(random):
	var circle_center = undead.target.global_position
	radius = 100
	var angle = random * PI * 2
	var x = circle_center.x + cos(angle) * radius
	var y = circle_center.y + sin(angle) * radius
	return Vector2(x, y)


func enter(_last_state):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	random_num = rng.randf()


func update(delta):
	if undead.target.is_dead == true:
		transition.emit("UndeadFollowState")
	var target = get_circle_position(random_num)
	move(target, delta)

func _on_hurtbox_area_entered(area):
	if area.is_in_group("npc"):
		#remove collision and references before removal
		# KILL NPC -> area.get_parent()
		area.get_parent().speed *= 0.9
		transition.emit("UndeadFollowState")
