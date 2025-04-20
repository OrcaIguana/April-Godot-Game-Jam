extends "res://Tile Sets/room.gd"

var boss = preload("res://Enemies/Boss/boss_phase.tscn")

func _ready() -> void:
	super._ready()

func spawn_enemies(difficulty):
	Global_Sound_System.location = "boss"
	var spawnpoint = $"Spawn Point"
	
	var spawned_boss = boss.instantiate()
	
	spawned_boss.spawn_location = spawnpoint.global_position
	call_deferred("add_child", spawned_boss)
