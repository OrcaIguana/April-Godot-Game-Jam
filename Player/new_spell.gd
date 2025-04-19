extends ColorRect

func _on_button_chosen() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	self.visible = false


func _on_button_spell(chosen_spell: Variant) -> void:
	self.visible = true
	get_node("Button").visible = true
	get_node("Button2").visible = true
	get_node("Button3").visible = true
	get_node("Button4").visible = true
