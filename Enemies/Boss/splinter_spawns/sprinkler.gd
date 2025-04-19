extends Node2D

const bullet_scene = preload("res://Enemies/enemy_bullet.tscn")
@export var shoot_interval := 1
@export var bullets_per_shot := 8
@export var rotation_speed := 200

var shoot_timer := 0.0
var current_angle := 0.0

func _process(delta):
	shoot_timer -= delta
	current_angle += rotation_speed * delta
	rotation = deg_to_rad(current_angle)

	if shoot_timer <= 0:
		shoot_bullets()
		shoot_timer = shoot_interval

func shoot_bullets():
	for i in range(bullets_per_shot):
		var angle = i * (2 * PI / bullets_per_shot) + rotation
		var bullet = bullet_scene.instantiate()
		bullet.spawn_position = global_position
		bullet.direction = Vector2(cos(angle), sin(angle))
		get_tree().current_scene.add_child(bullet)
