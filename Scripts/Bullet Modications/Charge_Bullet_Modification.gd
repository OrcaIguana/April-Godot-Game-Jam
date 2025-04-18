class_name Charge_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_charge = true

func initialize(val: bool):
	is_charge = val

func apply_modification(bullet : Bullet):
	bullet.is_charge = is_charge
	bullet.damage *= 2

func get_modifier_name() -> String:
	return "Charge"
