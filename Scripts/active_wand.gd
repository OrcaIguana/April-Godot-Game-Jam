extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0.5
var time_to_kill = 0.5
var projectiles = 3
var burst = 3
var burst_speed = 0.1
var spread = 30

var cooldown = 0

func _process(delta):
	if Input.is_action_just_released("shoot"):
		if cooldown <= 0:
			shoot(time_to_kill, projectiles, burst, spread)
			cooldown = max_cooldown
	cooldown -= delta

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 50

func shoot(time_to_kill, amount_of_projectiles, burst, spread):
	var counter = 0
	var loop = 0
	var instances = []
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(amount_of_projectiles):
			var instance = bullets.instantiate()
			var bullet = instance.get_node("CharacterBody2D")
			if negative:
				bullet.direction = direction.rotated(deg_to_rad(360 - (spread*counter)))
				negative = false
			else:
				bullet.direction = direction.rotated(deg_to_rad(spread*counter))
				negative = true
				counter += 1
			bullet.spawn_position = self.global_position
			bullet.time_to_live = time_to_kill
			get_tree().current_scene.add_child(instance)
		loop += 1
		if loop >= burst:
			break
		await get_tree().create_timer(burst_speed).timeout
		counter = 0
