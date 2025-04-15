class_name SplittingCount_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var splitting_count = 10
@export var splitting_lifespan = .5

func initialize(count: int, lifespan_mult: float,):
	splitting_count = count
	splitting_lifespan = lifespan_mult

func apply_modification(bullet : Bullet):
	bullet.splitting_count = splitting_count
	bullet.splitting_lifespan *= splitting_lifespan
