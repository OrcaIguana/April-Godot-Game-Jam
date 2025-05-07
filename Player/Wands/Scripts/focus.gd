extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	internal_name = "Focus"
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Speed_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(2.0)
	wand_modifiers.append(Cooldown_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.75)
	wand_modifiers.append(Strengthen_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(1.5)
	wand_modifiers.append(Charge_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)

func get_item_tooltip() -> String:
	return "Charge it up and see what happens."
