extends Camera2D

var target

func _ready():
	self.position = self.position + Vector2(-960, -540)
	target = self.position

func _physics_process(delta: float) -> void:
	self.position = self.position.lerp(target, 0.1)

func _on_player_room_change(direction: Variant) -> void:
	target = self.position + direction
