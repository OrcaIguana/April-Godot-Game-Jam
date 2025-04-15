extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Slow_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.5)
	wand_modifiers.append(SplittingAngle_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(360.0)
	wand_modifiers.append(SplittingCount_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(10, .15)
	super.set_wand_modifiers(wand_modifiers)
