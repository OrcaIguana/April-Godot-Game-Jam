extends "res://Scripts/active_wand.gd"

func _ready() -> void:
	internal_name = "Volley"
	var wand_modifiers : Array[Default_Bullet_Modification]	
	wand_modifiers.append(Burst_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(4)
	wand_modifiers.append(BurstSpeed_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.05)
	wand_modifiers.append(Spread_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(50)
	wand_modifiers.append(Weaken_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.75)
	wand_modifiers.append(Cooldown_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(1.25)
	wand_modifiers.append(Slow_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.5) 
	super.set_wand_modifiers(wand_modifiers)
