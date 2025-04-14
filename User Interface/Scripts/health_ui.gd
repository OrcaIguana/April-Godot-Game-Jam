extends Sprite2D

func _on_health_change(health):
	self.frame = 6 - health
	print("Health Bar Changed")
