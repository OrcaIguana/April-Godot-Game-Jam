class_name Spam_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_spam = true

func apply_modification(bullet : Bullet, new_is_spam = is_spam):
	bullet.is_spam = new_is_spam
