extends "res://Tile Sets/room.gd"

var boss = preload("res://Enemies/Boss/boss_phase.tscn")

func _ready() -> void:
	super._ready()

func spawn_enemies(difficulty):
	var spawnpoint = $"Spawn Point"
	
	var spawned_boss = boss.instantiate()
	
	spawned_boss.spawn_location = spawnpoint.global_position
	call_deferred("add_child", spawned_boss)

func shoot_laser():
	var laser = laser_scene.instantiate()
	laser.global_position = Vector2(global_position.x+rng.randi_range(-500, 500), global_position.y+rng.randi_range(-500, 500))
	rng.randomize()
	laser.rotation = rng.randf_range(0, 2*PI)
	get_tree().current_scene.add_child(laser)
