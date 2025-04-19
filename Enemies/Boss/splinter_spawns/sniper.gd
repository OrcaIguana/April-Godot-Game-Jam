extends CharacterBody2D

const bullet_scene = preload("res://Enemies/Boss/laser.tscn")
@export var speed := 50
@export var shoot_interval := 2
@export var shoot_range := 1000

var shoot_timer := 0.0

func _physics_process(delta):
	shoot_timer -= delta

	var distance = global_position.distance_to(get_player_position())

	if distance > shoot_range:
		velocity = (get_player_position() - global_position).normalized() * speed
	else:
		velocity = (global_position - get_player_position()).normalized() * speed
		if shoot_timer <= 0:
			shoot()
			shoot_timer = shoot_interval

	move_and_slide()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = (get_player_position() - global_position).normalized()
	get_tree().current_scene.add_child(bullet)

func get_player_position():
	return get_tree().get_first_node_in_group("player").global_position
