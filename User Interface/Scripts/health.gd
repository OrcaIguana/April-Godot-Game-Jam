extends TextureRect

var health = 6

var sprite_array = [
 preload("res://User Interface/Sprites/image7.png"),
 preload("res://User Interface/Sprites/image6.png"),
 preload("res://User Interface/Sprites/image5.png"),
 preload("res://User Interface/Sprites/image4.png"),
 preload("res://User Interface/Sprites/image3.png"),
 preload("res://User Interface/Sprites/image2.png"),
 preload("res://User Interface/Sprites/image1.png")
]

func _on_health_change(health):
	self.texture = sprite_array[max(health, 0)]
