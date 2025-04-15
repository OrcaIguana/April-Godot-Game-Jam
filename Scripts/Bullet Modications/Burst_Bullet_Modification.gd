class_name Burst_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var burst_addition = 2

func apply_modification(bullet : Bullet, new_burst_addition = burst_addition):
	bullet.burst += new_burst_addition
