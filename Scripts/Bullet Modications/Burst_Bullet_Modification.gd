class_name Burst_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var burst_addition = 4

func initialize(val: int):
	burst_addition = val

func apply_modification(bullet : Bullet):
	bullet.burst += burst_addition
