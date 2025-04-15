extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	super.set_stats(0.5, 1, 1, 5, 0.05, 10, 500)
	
func shoot(parent_pos: Vector2):
	var loop = 0
	var instances = []
	var volley_arc = [-2, -1, 0, 1, 2]
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(projectiles):
			var instance = bullets.instantiate()
			var bullet = instance.get_node("CharacterBody2D")
			bullet.direction = direction.rotated(deg_to_rad(volley_arc[loop] * spread))
			bullet.spawn_position = self.global_position
			bullet.time_to_live = time_to_kill
			bullet.speed = bullet_speed
			get_tree().current_scene.add_child(instance)
		loop += 1
		if loop >= burst:
			break
		await get_tree().create_timer(burst_speed).timeout
