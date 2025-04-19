extends CharacterBody2D

const bullet_scene = preload("res://Enemies/enemy_bullet.tscn")
@export var speed := 80
@export var shoot_interval := 0.4
@export var shoot_range := 800

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
	bullet.spawn_position = global_position
	bullet.direction = (get_player_position() - global_position).normalized()
	bullet.speed = 500
	get_tree().current_scene.add_child(bullet)

func get_player_position():
	return get_tree().get_first_node_in_group("player").global_position
