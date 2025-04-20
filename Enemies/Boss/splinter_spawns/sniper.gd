extends CharacterBody2D

const laser_scene = preload("res://Enemies/Boss/laser.tscn")
const bullet_scene = preload("res://Enemies/Boss/laser.tscn")
@export var speed := 50
@export var shoot_interval := 2
@export var shoot_range := 1000

var lock_rotation = false
var shoot_timer := 0.0

func _physics_process(delta):
	shoot_timer -= delta

	var distance = global_position.distance_to(get_player_position())

	if distance > shoot_range:
		velocity = (get_player_position() - global_position).normalized() * speed
	else:
		if(!lock_rotation):
			$Sprite2D2.rotation = get_direction_to_player().angle() + -30
		velocity = (global_position - get_player_position()).normalized() * speed
		if shoot_timer <= 0:
			shoot_laser()
			shoot_timer = shoot_interval

	move_and_slide()

func shoot_laser():
	var laser = laser_scene.instantiate()
	$Sprite2D2.play("attack")
	laser.global_position = self.global_position
	laser.rotation = get_direction_to_player().angle()
	get_tree().current_scene.add_child(laser)
	lock_rotation = true
	await get_tree().create_timer(1.2).timeout
	lock_rotation = false

func get_player_position():
	return get_tree().get_first_node_in_group("player").global_position


func _on_sprite_2d_2_animation_finished() -> void:
	$Sprite2D2.play("default")

func get_direction_to_player() -> Vector2:
	return (get_player_position() - global_position).normalized()
