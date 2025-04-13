extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var cooldown = 5
var time_to_kill = 0.5
var projectiles = 1

func _process(delta):
	if Input.is_action_just_released("shoot"):
		var instance = shoot(self.global_position, time_to_kill, projectiles)
		get_tree().current_scene.add_child(instance)

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 500

static func shoot(global_position: Vector2, time_to_kill, amount_of_projectiles):
	var instance = bullets.instantiate()
	instance.get_node("CharacterBody2D").spawn_position = global_position
	print("Spawned Bullet")
	return instance
