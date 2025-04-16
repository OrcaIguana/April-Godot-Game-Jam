extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Speed_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(2.5)
	wand_modifiers.append(Strengthen_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(2.5)
	wand_modifiers.append(Cooldown_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.75)
	wand_modifiers.append(Charge_Bullet_Modification.new())
	super.set_wand_modifiers(wand_modifiers)
