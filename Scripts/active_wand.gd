extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0
var time_to_kill = 1
var projectiles = 5
var burst = 0
var burst_speed = 0.2
var spread = 30
var bullet_speed = 1000

var cooldown = 0

var wand_modifiers : Array[Default_Bullet_Modification]
var modifiers : Array[Default_Bullet_Modification]

var dummyInstance = bullets.instantiate()
var dummyBullet = dummyInstance.get_node("CharacterBody2D")

func set_wand_modifiers(new_wand_modifiers: Array[Default_Bullet_Modification]):
	for mod in new_wand_modifiers:
		wand_modifiers.append(mod)
			
	dummyInstance = bullets.instantiate()
	dummyBullet = dummyInstance.get_node("CharacterBody2D")
	
	for wand_modifier in wand_modifiers:
		wand_modifier.apply_modification(dummyBullet)
			
	for modifier in modifiers:
		modifier.apply_modification(dummyBullet)
		
	print(dummyBullet.cooldown)
	max_cooldown=dummyBullet.cooldown

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 50

func shoot(parent_pos: Vector2):	
	var counter = 0
	var loop = 0
	while true:
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = global_position.direction_to(mouse_pos)
		for projectile in range(dummyBullet.burst):
			var instance = bullets.instantiate()
			var bullet = instance.get_node("CharacterBody2D")
			
			for wand_modifier in wand_modifiers:
				wand_modifier.apply_modification(bullet)
			
			for modifier in modifiers:
				modifier.apply_modification(bullet)
			
			bullet.direction = direction.rotated(deg_to_rad(-(bullet.spread/2.0)+((bullet.spread/bullet.burst)*(counter+.5))))
			counter += 1
			bullet.spawn_position = self.global_position
			get_tree().current_scene.add_child(instance)
			if(bullet.burst_speed > 0):
				await get_tree().create_timer(dummyBullet.burst_speed).timeout
		loop += 1
		if loop > 1 || !dummyBullet.is_echo:
			break
		counter = 0
