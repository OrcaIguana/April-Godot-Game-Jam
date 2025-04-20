extends CharacterBody2D

var speed: float = 100.0;
var follow_distance = 10000.0;
var is_dead : bool = false

var player: Node2D

var spawn_location: Vector2 = Vector2()

var health = 1

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	add_to_group("enemy")
	self.global_position = spawn_location
	
func is_player_in_range() -> bool:
	return player and global_position.distance_to(player.global_position) < follow_distance

func get_direction_to_player() -> Vector2:
	if player:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO

func _on_death():
	var XP = load("res://Enemies/XP.tscn").instantiate()
	XP.spawn_position = self.global_position
	get_tree().current_scene.add_child(XP)
	queue_free()

func hurt(amount):
	modulate.b = 255
	modulate.r = 255
	modulate.g = 255
	health -= amount
	if health <= 0:
		is_dead = true
	if is_dead:
		_on_death()
	await get_tree().create_timer(.1).timeout
	modulate.b = 1
	modulate.r = 1
	modulate.g = 1
