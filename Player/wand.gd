extends Sprite2D

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = self.global_position.direction_to(mouse_pos)
	self.rotation = direction.angle() + PI / 2
