class_name Seeking_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_seeking = true

func initialize(val: bool):
	is_seeking = val

func apply_modification(bullet : Bullet):
	bullet.is_seeking = is_seeking
	bullet.speed = max(bullet.speed, 300)

func get_modifier_name() -> String:
	return "Seeking"

func get_item_tooltip() -> String:
	return "Aiming? What's that?"
