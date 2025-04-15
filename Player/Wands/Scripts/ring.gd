extends "res://Scripts/active_wand.gd"

func _ready():
	super.set_stats(1, 0.5, 12, 1, 0, 30, 200)

func shoot(parent_pos: Vector2):
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
			bullet.spawn_position = parent_pos + bullet.direction * 10
			bullet.time_to_live = time_to_kill
			bullet.speed = bullet_speed
			get_tree().current_scene.add_child(instance)
		loop += 1
		if loop >= burst:
			break
		await get_tree().create_timer(burst_speed).timeout
		counter = 0
