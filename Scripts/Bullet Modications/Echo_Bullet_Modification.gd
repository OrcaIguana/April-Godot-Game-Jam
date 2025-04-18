class_name Echo_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var is_echo = true

func initialize(val: bool):
	is_echo = val

func apply_modification(bullet : Bullet):
	bullet.is_echo = is_echo
	bullet.echo_count += 1

func get_modifier_name() -> String:
	return "Echo"
