class_name BurstSpeed_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

# NOT A SPELL!

@export var burst_speed_addition = 0.05

func initialize(val: float):
	burst_speed_addition = val

func apply_modification(bullet : Bullet):
	bullet.burst_speed = burst_speed_addition

func get_modifier_name() -> String:
	return "Invalid Spell: BurstSpeed"
