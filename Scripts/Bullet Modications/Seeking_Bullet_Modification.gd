class_name Seeking_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_seeking = true

func apply_modification(bullet : Bullet, new_is_seeking = is_seeking):
	bullet.is_seeking = new_is_seeking
