extends TextureRect

var id = 3

func _on_wand_swap(id, new_texture):
	if id == self.id:
		self.texture = new_texture
