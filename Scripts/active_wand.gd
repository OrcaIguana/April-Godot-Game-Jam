extends Node2D

const bullets = preload("res://Player/player_bullet.tscn")

var max_cooldown = 0
var charge_time = 0
var charge = 0

var cooldown = 0

var internal_name = "Name"

var wand_modifiers : Array[Default_Bullet_Modification]
var spell_modifiers : Array[Default_Bullet_Modification]

# Dummy bullet for getting bullet attributes for shooting
var dummyInstance = bullets.instantiate()
var dummyBullet = dummyInstance.get_node("CharacterBody2D")

# Gets name of wand for UI purposes
func get_internal_name():
	return internal_name

# Called when new wand is created
func set_wand_modifiers(new_wand_modifiers: Array[Default_Bullet_Modification]):
	for mod in new_wand_modifiers:
		wand_modifiers.append(mod)
	apply_modifiers()
	
# Called when spells on a wand are changes
func set_spell_modifiers(new_spell_modifiers: Array):
	# spell_modifiers.clear()
	
	for modifier in new_spell_modifiers:
		spell_modifiers.append(modifier)
	apply_modifiers()
	
#Applies modifiers to the dummy bullet.
func apply_modifiers(): 
	dummyInstance = bullets.instantiate()
	dummyBullet = dummyInstance.get_node("CharacterBody2D")
	
	for wand_modifier in wand_modifiers:
		wand_modifier.apply_modification(dummyBullet)
			
	for modifier in spell_modifiers:
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
	Global_Sound_System.play_sound(Global_Sound_System.player_shoot_sound)
	var counter = 0
	var loop = 0
	while true:
		for projectile in range(dummyBullet.burst):
			var mouse_pos = get_global_mouse_position()
			var direction = global_position.direction_to(mouse_pos)
			var instance = bullets.instantiate()
			var bullet = instance.get_node("CharacterBody2D")
			
			for wand_modifier in wand_modifiers:
				wand_modifier.apply_modification(bullet)
			
			for spell_modifier in spell_modifiers:
				spell_modifier.apply_modification(bullet)
			
			bullet.direction = direction.rotated(deg_to_rad(-(bullet.spread/2.0)+((bullet.spread/bullet.burst)*(counter+.5))))
			counter += 1
			bullet.spawn_position = self.global_position
			get_tree().current_scene.add_child(instance)
			if(bullet.burst_speed > 0):
				await get_tree().create_timer(dummyBullet.burst_speed).timeout
				
		loop += 1
		if loop > dummyBullet.echo_count || !dummyBullet.is_echo:
			break
		if(dummyBullet.is_echo):
			await get_tree().create_timer(.25).timeout
		counter = 0
