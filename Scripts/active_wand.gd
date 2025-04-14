extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0
var time_to_kill = 0
var projectiles = 0
var burst = 0
var burst_speed = 0
var spread = 0
var bullet_speed = 0

var cooldown = 0

func set_stats(cooldown: float, TTK: float, projectile_amount: int, burst_amount: int, burst_firerate: float, spread_amount: int, speed_of_bullet: float):
	max_cooldown = cooldown
	time_to_kill = TTK
	projectiles = projectile_amount
	burst = burst_amount
	burst_speed = burst_firerate
	spread = spread_amount
	bullet_speed = speed_of_bullet
	

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 50

func shoot():
	var counter = 0
	var loop = 0
	var instances = []
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(projectiles):
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
			bullet.speed = bullet_speed
			get_tree().current_scene.add_child(instance)
		loop += 1
		if loop >= burst:
			break
		await get_tree().create_timer(burst_speed).timeout
		counter = 0
