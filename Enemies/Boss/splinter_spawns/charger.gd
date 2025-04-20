extends CharacterBody2D

@export var speed = 300
@export var chase_duration = 3.0
@export var rest_duration = 1.

var chasing = true
var timer = 0.0

func _physics_process(delta):
	timer -= delta

	if chasing:
		var dir = (get_player_position() - global_position).normalized()
		$Sprite2D.rotation = get_direction_to_player().angle()
		velocity = dir * (speed + randi_range(0,100))
		if timer <= 0:
			chasing = false
			timer = rest_duration + randf_range(0, .3)
	else:
		velocity = Vector2.ZERO
		if timer <= 0:
			chasing = true
			timer = chase_duration + randf_range(0, .5)

	move_and_slide()

func get_player_position():
	return get_tree().get_first_node_in_group("player").global_position

func get_direction_to_player() -> Vector2:
	return (get_player_position() - global_position).normalized()
