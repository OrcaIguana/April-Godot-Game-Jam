extends Camera2D

var target
var last_position : Vector2

func _ready():
	self.position = self.position + Vector2(-960, -540)
	last_position = self.position
	target = self.position

func _physics_process(delta: float) -> void:
	self.position = self.position.lerp(target, 0.1)

func _on_player_room_change(direction: Variant) -> void:
	target = last_position + direction
	last_position = target
	get_tree().call_group("friendly_bullets", "queue_free")
	get_tree().call_group("enemy_bullets", "queue_free")
