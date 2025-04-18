class_name Vacuum_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var suck = 1

func initialize(val: int):
	suck = val

func apply_modification(bullet : Bullet):
	bullet.sucking += suck

func get_modifier_name() -> String:
	return "Vacuum"
