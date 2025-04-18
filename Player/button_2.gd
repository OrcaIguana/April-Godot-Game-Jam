extends Button

signal wand_selection(current_selection)

var current_selection

func _ready() -> void:
	get_tree().paused = true
	_choose_slot()

func _choose_slot():
	var wands = get_node("../../../Player").wand_inventory
	var selected_wand = wands[1]
	self.text = "None"
	if selected_wand != null:
		self.icon = selected_wand.get_node("Wand").texture

func _on_pressed() -> void:
	get_tree().paused = false
	wand_selection.emit([current_selection], 1)
