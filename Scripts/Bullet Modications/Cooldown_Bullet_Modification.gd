class_name Cooldown_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var cooldown_multiplier = 2

func initialize(val: float):
	cooldown_multiplier = val

func apply_modification(bullet : Bullet):
	bullet.cooldown *= cooldown_multiplier

func get_modifier_name() -> String:
	return "Invalid Spell: Increase Cooldown (Cooldown)"
