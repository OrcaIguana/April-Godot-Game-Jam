class_name Speed_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var speed_multiplier = 2

func apply_modification(bullet : Bullet, new_speed_multiplier = speed_multiplier):
	bullet.speed *= new_speed_multiplier
