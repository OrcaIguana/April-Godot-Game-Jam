class_name Coolup_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var coolup_multiplier = .5

func initialize(val: float):
	coolup_multiplier = val

func apply_modification(bullet : Bullet):
	bullet.cooldown *= coolup_multiplier
