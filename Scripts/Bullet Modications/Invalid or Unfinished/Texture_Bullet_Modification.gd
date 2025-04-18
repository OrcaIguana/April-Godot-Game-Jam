class_name Texture_Bullet_Modification
extends "res://Scripts/Bullet Modications/Default_Bullet_Modification.gd"

@export var texture = preload("res://Player/Sprites/player-bullet.png")

func initialize(val: Texture2D):
	texture = val

func apply_modification(bullet : Bullet):
	bullet.texture = texture

func get_modifier_name() -> String:
	return "Invalid Spell: Texture"
