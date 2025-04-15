class_name Charge_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_charge = true

func apply_modification(bullet : Bullet, new_is_charge = is_charge):
	bullet.is_charge = new_is_charge
