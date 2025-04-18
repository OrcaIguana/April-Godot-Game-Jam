extends "res://Scripts/active_wand.gd"

func _ready():
	internal_name = "Ring"
	var wand_modifiers : Array[Default_Bullet_Modification]
	wand_modifiers.append(Burst_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(11)
	wand_modifiers.append(BurstSpeed_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0)
	wand_modifiers.append(Spread_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(360)
	wand_modifiers.append(Cooldown_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(1.5)
	wand_modifiers.append(Slow_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0.15)
	wand_modifiers.append(Lifespan_Bullet_Modification.new())
	wand_modifiers[wand_modifiers.size()-1].initialize(0)
	super.set_wand_modifiers(wand_modifiers)
