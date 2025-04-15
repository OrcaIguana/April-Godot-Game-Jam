extends TextureRect

var id = 2

func _on_wand_swap(id, new_texture):
	if id == self.id:
		self.texture = new_texture
