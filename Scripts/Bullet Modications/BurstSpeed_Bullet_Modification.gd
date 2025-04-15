class_name BurstSpeed_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var burst_speed_addition = 0.05

func apply_modification(bullet : Bullet, new_burst_speed_addition = burst_speed_addition):
	bullet.burst_speed = new_burst_speed_addition
