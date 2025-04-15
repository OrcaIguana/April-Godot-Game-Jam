class_name Strengthen_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var damage_multiplier = 1.5

func apply_modification(bullet : Bullet, new_damage_multiplier = damage_multiplier):
	bullet.damage *= new_damage_multiplier
