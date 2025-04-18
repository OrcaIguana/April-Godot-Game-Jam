extends Button

# Determines whether it is a wand or a spell. < 50 is more likely to be a wand. > 50 is more likely to be a spell
var bias = 50 

var current_selection

var currently_spell

signal chosen

var current_wands = [
	preload("res://Player/Wands/focus.tscn"),
	preload("res://Player/Wands/blaster.tscn"),
	preload("res://Player/Wands/fan.tscn"),
	preload("res://Player/Wands/ring.tscn"),
	preload("res://Player/Wands/voley.tscn"),
	preload("res://Player/Wands/launcher.tscn")
]

var current_spells = [
	Echo_Bullet_Modification.new(),
	Slow_Bullet_Modification.new(),
	Spam_Bullet_Modification.new(),
	Stun_Bullet_Modification.new(),
	Burst_Bullet_Modification.new(),
	Orbit_Bullet_Modification.new(),
	Speed_Bullet_Modification.new()
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
	_choose_slot()

func _choose_slot():
	var is_spell = randi_range(0, 100) > bias
	
	if is_spell:
		current_selection = current_spells[randi_range(0, len(current_spells)-1)].instantiate()
		bias -= 10
	else:
		current_selection = current_wands[randi_range(0, len(current_wands)-1)].instantiate()
		bias += 10
	if is_spell:
		self.icon = spell_icons[randi_range(0, len(spell_icons))]
		self.text = current_selection
	else:
		self.icon = current_selection.get_node("Wand").texture


func _on_pressed() -> void:
	get_tree().paused = false
	chosen.emit()
	on_press.emit(current_selection)
