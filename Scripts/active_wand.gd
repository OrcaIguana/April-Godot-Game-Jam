extends Node2D

var wand_images = [preload("res://icon.svg"), preload("res://Sprites/circle.png"), preload("res://Sprites/Slot.png")]

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 100

func _on_button_on_press(id):
	print("Signal Recieved")
	get_node("Sprite2D2").change_wand_image()
