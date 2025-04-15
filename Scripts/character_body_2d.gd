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

var health = 6
var invulnerable = false

const dash_cooldown = 0.7
var is_dashing = false
var locked_direction
var dash_duration = 0

signal health_change(health)
signal wand_change(id, want_texture)
signal wand_progress_bar(id, max_cooldown, current_cooldown)

func health_changed(new_health):
	health_change.emit(new_health)

func hurt(amount):
	if !invulnerable:
		health_change.emit(health - amount)
		print("Sent Signal")
	else:
		pass # Some dodge sfx or smth

func load_wand(wand):
		var loaded_wand = wand.instantiate()
		loaded_wand.visible = false
		add_child(loaded_wand)
		return	loaded_wand

func do_cooldowns(delta):
	var counter = 1
	for wands in wand_inventory:
		wands.cooldown -= delta
		wand_progress_bar.emit(counter, wands.max_cooldown, wands.cooldown)
		counter += 1
	dash_duration -= delta
	get_node("Dash/Dash Cooldown Bar").adjust_dash_bar((dash_duration+(dash_cooldown))/.7)

func _ready():
	var wand
	add_to_group("player")
	for i in range(4):
		wand_inventory.append(load_wand(default_wand))
	wand_inventory[0] = load_wand(launcher)
	active_wand = wand_inventory[0]
	wand_inventory[1] = load_wand(ring)
	wand_inventory[2] = load_wand(volley)
	wand_inventory[3] = load_wand(focus)
	
	await get_tree().create_timer(5).timeout
	
func get_input():
	var input
	if is_dashing:
		input = locked_direction
		speed = 500 + 7000*max(dash_duration,0)
	else:
		input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed

func _process(delta: float) -> void:
	if Input.is_action_just_released("shoot"):
		if active_wand.cooldown <= 0:
			active_wand.shoot(self.global_position)
			active_wand.cooldown = active_wand.max_cooldown
	do_cooldowns(delta)
	
	if Input.is_action_just_released("slot1"):
		wand_inventory[0].visible = true
		wand_inventory[1].visible = false
		wand_inventory[2].visible = false
		wand_inventory[3].visible = false
		active_wand = wand_inventory[0]
		wand_change.emit(1, active_wand.get_node("Wand").texture)
	if Input.is_action_just_released("slot2"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = true
		wand_inventory[2].visible = false
		wand_inventory[3].visible = false
		active_wand = wand_inventory[1]
		wand_change.emit(2, active_wand.get_node("Wand").texture)
	if Input.is_action_just_released("slot3"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = false
		wand_inventory[2].visible = true
		wand_inventory[3].visible = false
		active_wand = wand_inventory[2]	
		wand_change.emit(3, active_wand.get_node("Wand").texture)
	if Input.is_action_just_released("slot4"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = false
		wand_inventory[2].visible = false
		wand_inventory[3].visible = true
		active_wand = wand_inventory[3]
		wand_change.emit(4, active_wand.get_node("Wand").texture)	
	
	if Input.is_action_just_pressed("dash") && (dash_duration <= -dash_cooldown):
		get_node("Dash/Ghost Particles").set_emitting(true)
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
	get_input()
	move_and_slide()


func _on_health_change(health: Variant) -> void:
	pass # Replace with function body.
