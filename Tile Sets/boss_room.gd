extends "res://Tile Sets/room.gd"

var boss1 = preload("res://Enemies/Boss/boss_phase.tscn")
var boss2 = preload("res://Enemies/Boss/boss_splinter.tscn")

func _ready() -> void:
	super._ready()

func spawn_enemies(difficulty):
	Global_Sound_System.location = "boss"
	var spawnpoint = $"Spawn Point"
	var rng = RandomNumberGenerator.new()
	var spawned_boss
	if(rng.randi_range(0,1)==0):
		spawned_boss = boss1.instantiate()
	else:
		spawned_boss = boss2.instantiate()
	spawned_boss.spawn_location = spawnpoint.global_position
	call_deferred("add_child", spawned_boss)
