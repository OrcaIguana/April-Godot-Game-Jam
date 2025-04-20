extends Button

signal wand_selection(current_selection)
signal chosen

var current_selection

func _ready() -> void:
	self.visible = true
	_choose_slot()

func _choose_slot():
	var wands = get_node("../../../Player").wand_inventory
	var selected_wand = wands[0]
	if selected_wand != null:
		self.text = selected_wand.name
		self.icon = selected_wand.get_node("Wand").texture
	else:
		self.visible = false

func _on_pressed() -> void:
	get_tree().paused = false
	wand_selection.emit([current_selection], 0)
	chosen.emit()


func _on_button_spell(chosen_spell: Variant) -> void:
	current_selection = chosen_spell


func _on_visibility_changed() -> void:
	if self.visible:
		_choose_slot()
