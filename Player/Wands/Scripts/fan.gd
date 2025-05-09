extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	internal_name = "Fan"
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Burst_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(4)
	wand_modifiers.append(BurstSpeed_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0)
	wand_modifiers.append(Spread_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(45)
	wand_modifiers.append(Cooldown_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)

func get_item_tooltip() -> String:
	return "Shotgun style."
