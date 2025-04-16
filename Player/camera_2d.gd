extends Camera2D

func _ready():
	self.position = self.position + Vector2(-960, -540)

func _on_player_room_change(direction: Variant) -> void:
	self.position = self.position + direction
