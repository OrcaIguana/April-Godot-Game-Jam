class_name Cooldown_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var cooldown_multiplier = 2

func apply_modification(bullet : Bullet, new_cooldown_multiplier = cooldown_multiplier):
	bullet.cooldown *= new_cooldown_multiplier
