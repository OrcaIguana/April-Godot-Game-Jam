class_name Spread_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var spread = 10

func apply_modification(bullet : Bullet, new_spread = spread):
	bullet.spread = new_spread
