class_name Lifespan_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var lifespan_addition = 1

func initialize(val: float):
	lifespan_addition = val

func apply_modification(bullet : Bullet):
	bullet.lifespan += lifespan_addition
