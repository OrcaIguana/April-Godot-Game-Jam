extends ColorRect

var selected_upgrades : Array = []

func _on_button_chosen() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	self.visible = false

func _on_visibility_changed() -> void:
	if(self.visible):
		get_node("Button")._choose_slot()
		get_node("Button2")._choose_slot()
		get_node("Button3")._choose_slot()
		selected_upgrades.clear()

func get_selected_upgrades() -> Array:
	return selected_upgrades
