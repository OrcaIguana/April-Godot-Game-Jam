class_name Orbit_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_orbit = true

func apply_modification(bullet : Bullet, new_is_orbit = is_orbit):
	bullet.is_orbit = new_is_orbit
