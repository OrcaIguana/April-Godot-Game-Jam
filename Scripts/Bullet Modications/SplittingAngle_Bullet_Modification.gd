class_name SplittingAngle_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var splitting_angle = 30

func initialize(val: float):
	splitting_angle = val

func apply_modification(bullet : Bullet):
	bullet.splitting_angle = min(splitting_angle, 360)

func get_modifier_name() -> String:
	return "Invalid Spell: SplittingAngle"
