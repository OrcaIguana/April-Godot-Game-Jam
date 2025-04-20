extends CharacterBody2D

@export var speed = 500

const default_wand = preload("res://Player/wand.tscn")
const focus = preload("res://Player/Wands/focus.tscn")
const blaster = preload("res://Player/Wands/blaster.tscn")
const fan = preload("res://Player/Wands/fan.tscn")
const ring = preload("res://Player/Wands/ring.tscn")
const volley = preload("res://Player/Wands/voley.tscn")
const launcher = preload("res://Player/Wands/launcher.tscn")

var wand_inventory = []
var active_wand
var activeWandIndex = 0

var level = 0
var next_level_xp = 2
var current_xp = 0

var health = 6
var invulnerable = false
var is_dead = false

const dash_cooldown = 0.7
var is_dashing = false
var locked_direction
var dash_duration = 0

signal health_change(health)
signal wand_change(id, want_texture)
signal wand_progress_bar(id, max_cooldown, current_cooldown)
signal room_change(direction)
signal dead
signal level_up_signal
signal menu_button_signal

func health_changed(new_health):
	health_change.emit(new_health)

func hurt(amount):
	if !invulnerable:
		modulate.r = 255
		Global_Sound_System.play_sound(Global_Sound_System.player_hit_sound)
		var new_health = health - amount
		health_change.emit(new_health)
		health = new_health
		if health == 0:
			is_dead = true
			dead.emit()
		invulnerable = true
		await get_tree().create_timer(.3).timeout
		modulate.r = 1
		invulnerable = false
	else:
		pass # Some dodge sfx or smth

func level_up():
	Global_Sound_System.play_sound(Global_Sound_System.level_up_sound)
	level_up_signal.emit()
	get_tree().paused = true
	level_up_signal.emit()

	
func wand_get(wand):
	add_child(wand)
	wand.visible = false
	var location = wand_inventory.find(null)
	wand_inventory[location] = wand
	change_wand_index(location)
	
	
func spell_add(spell, slot):
	wand_inventory[slot].set_spell_modifiers(spell)

func load_wand(wand):
		var loaded_wand = wand.instantiate()
		loaded_wand.visible = false
		add_child(loaded_wand)
		return	loaded_wand

func do_cooldowns(delta):
	var counter = 1
	for wands in wand_inventory:
		if wands == null:
			continue
		wands.cooldown -= delta
		wand_progress_bar.emit(counter, wands.max_cooldown, wands.cooldown)
		counter += 1
	dash_duration -= delta
	get_node("Dash/Dash Cooldown Bar").adjust_dash_bar((dash_duration+(dash_cooldown))/.7)

func _ready():
	var wand
	add_to_group("player")
	for i in range(4):
		wand_inventory.append(null)
	wand_inventory[0] = load_wand(blaster)
	active_wand = wand_inventory[0]
	change_wand_index(0)
	invulnerable = true
	await get_tree().create_timer(2).timeout
	invulnerable = false
	
func get_input():
	var input
	if is_dashing:
		input = locked_direction
		speed = 500 + 7000*max(dash_duration,0)
	else:
		input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed

func _process(delta: float) -> void:
	if is_dead:
		return
		
	if Input.is_action_just_pressed("menu"):
		print("Menu pressed")
		menu_button_signal.emit()
		get_tree().paused = true
		#get_tree().current_scene.add_child(SettingsMenu)
		#get_tree().paused = true
		
		
	if Input.is_action_just_released("shoot"):
		if active_wand.cooldown <= 0 && active_wand.charge >= active_wand.charge_time:
			active_wand.shoot(self.global_position)
			active_wand.cooldown = active_wand.max_cooldown
	do_cooldowns(delta)
	
	if current_xp >= next_level_xp:
		current_xp = 0
		next_level_xp += 3
		level_up()
	
	if (Input.is_action_pressed("shoot") && (active_wand.cooldown <= 0 && active_wand.charge_time>0)):
		active_wand.charge+=delta*2
	else:
		active_wand.charge = min(max(active_wand.charge - (delta*10), 0), active_wand.charge_time)
	
	if Input.is_action_just_released("slot1"):
		change_wand_index(0)
	if Input.is_action_just_released("slot2"):
		change_wand_index(1)
	if Input.is_action_just_released("slot3"):
		change_wand_index(2)
	if Input.is_action_just_released("slot4"):
		change_wand_index(3)
	
	if Input.is_action_just_released("swap_wand"):
		activeWandIndex+=1
		if (activeWandIndex > 3):
			activeWandIndex=0
		change_wand_index(activeWandIndex)
		
	
	if Input.is_action_just_pressed("dash") && (dash_duration <= -dash_cooldown):
		get_node("Dash/Ghost Particles").set_emitting(true)
		Global_Sound_System.play_sound(Global_Sound_System.dash_sound)
		is_dashing = true
		invulnerable = true
		dash_duration = 0.2
		locked_direction = Input.get_vector("left", "right", "up", "down")
		if(locked_direction == Vector2(0,0)): 
			locked_direction = Vector2(.8,0).rotated(round((get_local_mouse_position().angle()*(4/3.14)))*(3.14/4))
	elif (dash_duration <= 0.05):
		invulnerable = false
		if (dash_duration <= 0):
			speed = 500
			is_dashing = false
			get_node("Dash/Ghost Particles").set_emitting(false)
	
	
func _physics_process(_delta):
	if is_dead:
		return
	get_input()
	move_and_slide()

func change_wand_index(index):
	if wand_inventory[index] == null:
		return
	activeWandIndex = index
	active_wand = wand_inventory[index]
	wand_change.emit(index+1, active_wand.get_node("Wand").texture)
	
	for i in range(4):
		if (i == index):
			wand_inventory[i].visible = true
		else:
			if wand_inventory[i] == null:
				continue
			wand_inventory[i].visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.type == "enemy":
		hurt(1)
		area.kill_self()
	if area.type == "door_left":
		self.position = self.position + Vector2(-250, 0)
		room_change.emit(Vector2(-2000, 0))
		invulnerable = true
		await get_tree().create_timer(1).timeout
		invulnerable = false
	if area.type == "door_up":
		self.position = self.position + Vector2(0, -250)
		room_change.emit(Vector2(0, -1200))
		invulnerable = true
		await get_tree().create_timer(1).timeout
		invulnerable = false
	if area.type == "door_right":
		self.position = self.position + Vector2(250, 0)
		room_change.emit(Vector2(2000, 0))
		invulnerable = true
		await get_tree().create_timer(1).timeout
		invulnerable = false
	if area.type == "door_down":
		self.position = self.position + Vector2(0, 250)
		room_change.emit(Vector2(0, 1200))
		invulnerable = true
		await get_tree().create_timer(1).timeout
		invulnerable = false
	if area.type == "XP":
		Global_Sound_System.play_sound(Global_Sound_System.xp_pickup_sound)
		current_xp += 1
		area.kill_self()
	if area.type == "enemy_laser":
		hurt(1)
