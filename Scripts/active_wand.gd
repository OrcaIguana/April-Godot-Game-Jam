extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0
var time_to_kill = 1
var projectiles = 1
var burst = 0
var burst_speed = 0
var spread = 0

var cooldown = 0

var wand_modifiers : Array[Default_Bullet_Modification]
var modifiers : Array[Default_Bullet_Modification]

# Testing
func add_mod():
	modifiers.append(Speed_Bullet_Modification.new())

func set_wand_modifiers(new_wand_modifiers: Array[Default_Bullet_Modification]):
	for mod in new_wand_modifiers:
		wand_modifiers.append(mod)

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 50

func shoot(parent_pos: Vector2):
	var instance = bullets.instantiate()
	var bullet = instance.get_node("CharacterBody2D")
	
	get_tree().root.add_child(bullet)
	
	for wand_modifier in wand_modifiers:
		wand_modifier.apply_modification(bullet)
	
	for modifier in modifiers:
		modifier.apply_modification(bullet)
	
	var counter = 0
	var loop = 0
	var instances = []
	while true:
		var negative = false
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectiles in range(projectiles):
			#var instance = bullets.instantiate()
			#var bullet = instance.get_node("CharacterBody2D")
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
