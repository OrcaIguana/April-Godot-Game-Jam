class_name SplittingCount_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var splitting_count = 3
@export var splitting_lifespan = 1.5

func initialize(count: int, lifespan_mult: float,):
	splitting_count = count
	splitting_lifespan = lifespan_mult

func apply_modification(bullet : Bullet):
	bullet.splitting_count += splitting_count
	if(bullet.splitting_angle == 0):
		bullet.splitting_angle = 90;
	bullet.splitting_lifespan *= splitting_lifespan

func get_modifier_name() -> String:
	return "Shard"
