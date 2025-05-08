extends Button

# Determines whether it is a wand or a spell. < 50 is more likely to be a wand. > 50 is more likely to be a spell
var bias = 35

var current_selection

var currently_spell

signal spell(chosen_spell)
signal chosen

var current_wands = [
	preload("res://Player/Wands/focus.tscn"),
	preload("res://Player/Wands/fan.tscn"),
	preload("res://Player/Wands/ring.tscn"),
	preload("res://Player/Wands/voley.tscn"),
	preload("res://Player/Wands/launcher.tscn")
]

var current_spells = [
	Echo_Bullet_Modification.new(),
	Burst_Bullet_Modification.new(),
	Orbit_Bullet_Modification.new(),
	Speed_Bullet_Modification.new(),
	Charge_Bullet_Modification.new(),
	Strengthen_Bullet_Modification.new(),
	Repulse_Bullet_Modification.new(),
	Seeking_Bullet_Modification.new(),
	Bouncing_Bullet_Modification.new(),
	Vacuum_Bullet_Modification.new(),
	Coolup_Bullet_Modification.new(),
	Piercing_Bullet_Modification.new(),
	SplittingCount_Bullet_Modification.new(),
]

var spell_icons = [
	preload("res://Sprites/item-icon-blue.png"),
	preload("res://Sprites/item-icon-pink.png"),
	preload("res://Sprites/item-icon-red.png"),
	preload("res://Sprites/item-icon-purple.png"),
	preload("res://Sprites/item-icon-cyan.png"),
	preload("res://Sprites/item-icon-orange.png"),
	preload("res://Sprites/item-icon-green.png")
]

signal on_press(current_selection)

func _ready() -> void:
	$Tooltip.visible = true
	#_choose_slot()

func _choose_slot():
	var is_spell = true
	var selected_upgrades : Array = $"..".get_selected_upgrades()
	is_spell = randi_range(0, 100) > bias
	
	while(true):
		if is_spell:
			current_selection = current_spells[randi_range(0, len(current_spells)-1)]
			if(!selected_upgrades.has(current_selection.get_modifier_name())):
				$"..".selected_upgrades.append(current_selection.get_modifier_name());
				bias -= 10
				break;
		else:
			current_selection = current_wands[randi_range(0, len(current_wands)-1)].instantiate()
			if(!selected_upgrades.has(current_selection.get_name())):
				$"..".selected_upgrades.append(current_selection.get_name());
				bias += 10
				break;
	bias = max(min(bias, 80),20)
	if is_spell:
		$MarginContainer/TextureRect.texture = spell_icons[randi_range(0, len(spell_icons)-1)]
		$MarginContainer.scale = Vector2(0.75,0.75)
		self.text = str(current_selection.get_modifier_name(), "\nSpell\n\n\n\n\n\n\n\n\n")
		$Tooltip.text = current_selection.get_item_tooltip()
		$MarginContainer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		
		self.currently_spell = true
	else:
		$MarginContainer/TextureRect.texture = current_selection.get_node("Wand").texture
		$MarginContainer.scale = Vector2(1.75,1.75)
		self.text = str(current_selection.name, "\nWand\n\n\n\n\n\n\n\n\n")
		$Tooltip.text = current_selection.get_item_tooltip()
		$MarginContainer.texture_filter = CanvasItem.TEXTURE_FILTER_PARENT_NODE
		
		self.currently_spell = false


func _on_pressed() -> void:
	if currently_spell:
		chosen.emit()
		spell.emit(current_selection)
		#_choose_slot()
	else:
		get_tree().paused = false
		chosen.emit()
		on_press.emit(current_selection)
		#_choose_slot()
