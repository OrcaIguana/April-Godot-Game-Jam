extends Node2D

var wands = {
	1 : preload("res://Sprites/Slot.png")
}

func _on_button_on_press(id):
	print("Signal Recieved")
	self.texture = wands.get(id)

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 100
