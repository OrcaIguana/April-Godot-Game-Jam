class_name Orbit_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_orbit = true

func initialize(val: bool):
	is_orbit = val

func apply_modification(bullet : Bullet):
	bullet.is_orbit = is_orbit
	bullet.lifespan = max(bullet.lifespan+1, 2)
	bullet.burst_speed = max(bullet.burst_speed, .15)
	bullet.splitting_lifespan = max(bullet.splitting_lifespan+1, 2)
	bullet.speed = max(bullet.speed, 1000)

func get_modifier_name() -> String:
	return "Orbit"
