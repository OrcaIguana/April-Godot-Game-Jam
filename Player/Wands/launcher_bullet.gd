extends "res://Player/player_bullet.gd"

const bullets = preload("res://Player/player_bullet.tscn")

func _physics_process(delta: float) -> void:
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0:
		shoot(self.global_position)
		queue_free()

func shoot(parent_pos: Vector2):
	var loop = 0
	var instances = []
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(8):
			var instance = bullets.instantiate()
			var bullet = instance.get_node("CharacterBody2D")
			bullet.direction = direction.rotated(deg_to_rad(projectiles * 45))
			bullet.spawn_position = self.global_position
			bullet.time_to_live = 0.2
			bullet.speed = 200
			get_tree().current_scene.add_child(instance)
		loop += 1
		if loop >= 1:
			break
		await get_tree().create_timer(0.1).timeout
