class_name Piercing_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_piercing = true

func apply_modification(bullet : Bullet, new_is_piercing = is_piercing):
	bullet.is_piercing = new_is_piercing
