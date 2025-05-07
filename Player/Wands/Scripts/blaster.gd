extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	internal_name = "Blaster"
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Slow_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)

func get_item_tooltip() -> String:
	return "The default wand."
