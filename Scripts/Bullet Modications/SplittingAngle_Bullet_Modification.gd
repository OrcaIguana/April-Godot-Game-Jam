class_name SplittingAngle_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var splitting_angle = 30

func apply_modification(bullet : Bullet, new_splitting_angle = splitting_angle):
	bullet.splitting_angle *= new_splitting_angle
