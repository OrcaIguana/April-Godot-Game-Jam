class_name Piercing_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_piercing = true

func initialize(val: bool):
	is_piercing = val

func apply_modification(bullet : Bullet):
	bullet.is_piercing = is_piercing
	bullet.speed *= 1.2

func get_modifier_name() -> String:
	return "Piercing"
