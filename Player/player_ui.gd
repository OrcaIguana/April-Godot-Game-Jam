extends Control

func _ready() -> void:
	self.position = self.position + Vector2(-750, 480)

func _on_player_room_change(direction: Variant) -> void:
	self.position = self.position + direction
