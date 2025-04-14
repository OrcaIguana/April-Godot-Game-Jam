extends CharacterBody2D

@export var speed = 500

const default_wand = preload("res://Player/wand.tscn")
const focus = preload("res://Player/Wands/focus.tscn")
const blaster = preload("res://Player/Wands/blaster.tscn")
const fan = preload("res://Player/Wands/fan.tscn")
const ring = preload("res://Player/Wands/ring.tscn")

var wand_inventory = []
var active_wand

func load_wand(wand):
		var loaded_wand = wand.instantiate()
		loaded_wand.visible = false
		add_child(loaded_wand)
		return	loaded_wand

func do_cooldowns(delta):
	for wands in wand_inventory:
		wands.cooldown -= delta

func _ready():
	var wand
	add_to_group("player")
	for i in range(4):
		wand_inventory.append(load_wand(default_wand))
	wand_inventory[0] = load_wand(focus)
	active_wand = wand_inventory[0]
	wand_inventory[1] = load_wand(blaster)
	wand_inventory[2] = load_wand(fan)
	wand_inventory[3] = load_wand(ring)
	
func get_input():
	var input = Input.get_vector("left", "right", "up", "down")
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
	if Input.is_action_just_released("slot2"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = true
		wand_inventory[2].visible = false
		wand_inventory[3].visible = false
		active_wand = wand_inventory[1]		
	if Input.is_action_just_released("slot3"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = false
		wand_inventory[2].visible = true
		wand_inventory[3].visible = false
		active_wand = wand_inventory[2]		
	if Input.is_action_just_released("slot4"):
		wand_inventory[0].visible = false
		wand_inventory[1].visible = false
		wand_inventory[2].visible = false
		wand_inventory[3].visible = true
		active_wand = wand_inventory[3]		
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
