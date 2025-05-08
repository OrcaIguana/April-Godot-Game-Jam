extends Sprite2D

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 10
