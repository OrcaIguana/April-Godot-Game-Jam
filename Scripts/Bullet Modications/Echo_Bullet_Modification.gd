class_name Echo_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_echo = true

func apply_modification(bullet : Bullet, new_is_echo = is_echo):
	bullet.is_echo = new_is_echo
