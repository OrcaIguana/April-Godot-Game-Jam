extends ColorRect

func _on_button_chosen() -> void:
	self.visible = false


func _on_button_spell(chosen_spell: Variant) -> void:
	self.visible = true
