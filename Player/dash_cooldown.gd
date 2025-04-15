extends ProgressBar

func adjust_dash_bar(dash_cooldown: float):
	if (dash_cooldown <= 0):
		self.visible = false
	else:
		self.value = max(1-dash_cooldown, 0)
		self.visible = true
