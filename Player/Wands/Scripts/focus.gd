extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Speed_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)
