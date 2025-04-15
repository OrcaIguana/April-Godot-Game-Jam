extends ProgressBar

var id = 1

func _update(id, max_cooldown, cooldown):
	if id == self.id:
		self.max_value = max_cooldown
		self.value = cooldown
