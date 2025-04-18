class_name Slow_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var speed_multiplier = 0.66

func initialize(val: float):
	speed_multiplier = val

func apply_modification(bullet : Bullet):
	bullet.speed *= speed_multiplier

func get_modifier_name() -> String:
	return "Invalid Spell: Slow Bullet"
