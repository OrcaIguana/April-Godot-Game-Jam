extends Control

signal health_change(health)

func _on_health_change(health):
	health_change.emit(health)
	print("UI emitted")
