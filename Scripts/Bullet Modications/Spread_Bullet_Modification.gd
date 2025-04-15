class_name Spread_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var spread = 50

func initialize(val: float):
	spread = val

func apply_modification(bullet : Bullet):
	bullet.spread = min(spread, 360)
