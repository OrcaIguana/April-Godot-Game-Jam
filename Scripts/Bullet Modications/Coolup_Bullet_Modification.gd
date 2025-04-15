class_name Coolup_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var coolup_multiplier = .5

func apply_modification(bullet : Bullet, new_coolup_multiplier = coolup_multiplier):
	bullet.cooldown *= new_coolup_multiplier
