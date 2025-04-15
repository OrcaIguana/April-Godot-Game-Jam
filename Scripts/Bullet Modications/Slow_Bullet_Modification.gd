class_name Slow_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var speed_multiplier = 0.66

func apply_modification(bullet : Bullet, new_speed_multiplier = speed_multiplier):
	bullet.speed *= new_speed_multiplier
