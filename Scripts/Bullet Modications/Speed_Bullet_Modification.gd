class_name Speed_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var speed_multiplier = 2

func initialize(val: float):
	speed_multiplier = val

func apply_modification(bullet : Bullet):
	bullet.speed *= speed_multiplier

func get_modifier_name() -> String:
	return "Speed Up"
