class_name Burst_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var burst_addition = 2

func initialize(val: int):
	burst_addition = val

func apply_modification(bullet : Bullet):
	bullet.burst += burst_addition
	if(bullet.spread == 0):
		bullet.spread += 30

func get_modifier_name() -> String:
	return "Burst"

func get_item_tooltip() -> String:
	return "Shoot a spread of projectiles."
