extends CharacterBody2D

const charger = preload("res://Enemies/Basic/enemy_charger.tscn")
const orbit = preload("res://Enemies/Basic/enemy_orbit.tscn")
const random = preload("res://Enemies/Basic/enemy_charger.tscn")
const square = preload("res://Enemies/Basic/enemy_square.tscn")
const shooter = preload("res://Enemies/Basic/enemy_shooter.tscn")
var enemies = [charger, orbit, random, square, shooter]
@export var speed := 50
@export var shoot_interval := 4
@export var shoot_range := 400

var shoot_timer := 0.0

func _physics_process(delta):
	shoot_timer -= delta

	var distance = global_position.distance_to(get_player_position())

	if distance > shoot_range:
		velocity = (get_player_position() - global_position).normalized() * speed
	else:
		velocity = (global_position - get_player_position()).normalized() * speed
		if shoot_timer <= 0:
			summon()
			shoot_timer = shoot_interval

	move_and_slide()

func summon():
	var enemy = enemies.pick_random().instantiate()
	enemy.global_position = self.global_position
	get_tree().current_scene.add_child(enemy)

func get_player_position():
	return get_tree().get_first_node_in_group("player").global_position
