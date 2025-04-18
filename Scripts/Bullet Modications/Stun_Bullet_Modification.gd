class_name Stun_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var stun_addition = 0.2

func initialize(val: float):
	stun_addition = val

func apply_modification(bullet : Bullet):
	bullet.stun_duration += stun_addition

func get_modifier_name() -> String:
	return "Stun"
