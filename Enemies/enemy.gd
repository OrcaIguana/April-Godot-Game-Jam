extends CharacterBody2D

var speed: float = 100.0;
var follow_distance = 400.0;

var player: Node2D

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	add_to_group("enemy")
	
func is_player_in_range() -> bool:
	return player and global_position.distance_to(player.global_position) < follow_distance

func get_direction_to_player() -> Vector2:
	if player:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
