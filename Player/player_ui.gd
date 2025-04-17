extends Control

func _ready() -> void:
	self.position = self.position + Vector2(-750, 480)

func _on_player_room_change(direction: Variant) -> void:
	self.position = self.position + direction


func _on_player_dead() -> void:
	$"Dead Screen".visible = true
	get_tree().paused = true


func _on_player_level_up_signal() -> void:
	$"Level Up Screen".visible = true
	$"Level Up Screen/Button"._ready()
