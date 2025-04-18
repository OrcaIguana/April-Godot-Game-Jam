class_name Strengthen_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var damage_multiplier = 1.5

func initialize(val: float):
	damage_multiplier = val

func apply_modification(bullet : Bullet):
	bullet.damage *= damage_multiplier

func get_modifier_name() -> String:
	return "Strengthen"
