class_name Lifespan_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var lifespan_addition = 1

func apply_modification(bullet : Bullet, new_lifespan_addition = lifespan_addition):
	bullet.damage += new_lifespan_addition
