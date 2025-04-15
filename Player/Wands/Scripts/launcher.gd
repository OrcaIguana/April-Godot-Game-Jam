extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Default_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)

var bullet = preload("res://Player/Wands/launcher_bullet.tscn")

func shoot(parent_pos: Vector2):
	var counter = 0
	var loop = 0
	var instances = []
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(projectiles):
			var instance = bullet.instantiate()
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
