class_name Bouncing_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_bouncing = true

func initialize(val: bool):
	is_bouncing = val

func apply_modification(bullet : Bullet):
	bullet.is_bouncing = is_bouncing
	bullet.lifespan += 1
	bullet.splitting_lifespan += 1
