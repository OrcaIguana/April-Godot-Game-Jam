extends Node2D

var spawn_position = Vector2()

func _ready():
	self.position = spawn_position

func _on_area_2d_kill() -> void:
	queue_free()
