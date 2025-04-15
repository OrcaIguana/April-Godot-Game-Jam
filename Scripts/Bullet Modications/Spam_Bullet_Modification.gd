class_name Spam_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_spam = true

func initialize(val: bool):
	is_spam = val

func apply_modification(bullet : Bullet):
	bullet.is_spam = is_spam
