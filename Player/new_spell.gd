extends ColorRect

func _on_button_chosen() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	self.visible = false


func _on_button_spell(chosen_spell: Variant) -> void:
	self.visible = true
