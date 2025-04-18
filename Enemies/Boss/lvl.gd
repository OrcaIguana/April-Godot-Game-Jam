extends Node2D

func _ready() -> void:
	var start_location = get_node("Dungeon")._get_start()
	# $Camera2D.position = start_location
	$Player.position = start_location + Vector2(960, 540)
