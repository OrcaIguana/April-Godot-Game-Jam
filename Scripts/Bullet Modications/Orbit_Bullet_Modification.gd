class_name Orbit_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_orbit = true

func initialize(val: bool):
	is_orbit = val

func apply_modification(bullet : Bullet):
	bullet.is_orbit = is_orbit
