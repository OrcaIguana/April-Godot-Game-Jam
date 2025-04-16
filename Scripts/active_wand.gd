extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0
var charge_time = 0
var charge = 0

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
	
	wand_modifiers.append(Orbit_Bullet_Modification.new())
	wand_modifiers.append(Seeking_Bullet_Modification.new())
	wand_modifiers.append(SplittingCount_Bullet_Modification.new())

	for wand_modifier in wand_modifiers:
		wand_modifier.apply_modification(dummyBullet)
			
	for modifier in modifiers:
		modifier.apply_modification(dummyBullet)
	
	max_cooldown=dummyBullet.cooldown
	if(dummyBullet.is_charge):
		charge_time = min(.5, max_cooldown)

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * (50 - min(charge, charge_time)*20)

func _process(delta):
	if(charge_time > 0):
		modulate = Color((1+min(.5,charge)), (1+min(.5,charge)), (1+min(.5,charge)), 1)
	
func shoot(parent_pos: Vector2):	
	var counter = 0
	var loop = 0
	while true:
		for projectile in range(dummyBullet.burst):
			var mouse_pos = get_viewport().get_mouse_position()
			var direction = global_position.direction_to(mouse_pos)
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
		if(dummyBullet.is_echo):
			print("echo")
			await get_tree().create_timer(.25).timeout
		counter = 0
