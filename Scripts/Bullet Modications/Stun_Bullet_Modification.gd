class_name Stun_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var stun_addition = 0.2

func apply_modification(bullet : Bullet, new_stun_addition = stun_addition):
	bullet.stun_duration += new_stun_addition
