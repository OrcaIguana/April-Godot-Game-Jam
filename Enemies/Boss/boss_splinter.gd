extends "res://Enemies/enemy.gd"

const laser_scene = preload("res://Enemies/Boss/laser.tscn")
const charger_spawn = preload("res://Enemies/Boss/splinter_spawns/charger.tscn")
const sprinkler_spawn = preload("res://Enemies/Boss/splinter_spawns/sprinkler.tscn")
const long_shooter_spawn = preload("res://Enemies/Boss/splinter_spawns/long_shooter.tscn")
const summoner_spawn = preload("res://Enemies/Boss/splinter_spawns/summoner.tscn")
const exploder_spawn = preload("res://Enemies/Boss/splinter_spawns/exploder.tscn")
const sniper_spawn = preload("res://Enemies/Boss/splinter_spawns/sniper.tscn")

const charger = preload("res://Enemies/Basic/enemy_charger.tscn")
const orbit = preload("res://Enemies/Basic/enemy_orbit.tscn")
const random = preload("res://Enemies/Basic/enemy_charger.tscn")
const square = preload("res://Enemies/Basic/enemy_square.tscn")
const shooter = preload("res://Enemies/Basic/enemy_shooter.tscn")
var enemies = [charger, orbit, random, square, shooter]

@export var laser_interval = 2.5
@export var spawn_timer_interval = 3.0
@export var min_spawn_count = 1
@export var max_spawn_count = 1
@export var max_health = 200

var rng = RandomNumberGenerator.new()

func _ready():
	super._ready()
	health = max_health
	speed = 0
	rng.randomize()
	
	$AnimatedSprite2D.play("angry")
	
	$ShootTimer.timeout.connect(_on_shoot_timer_timeout)
	$ShootTimer.start(laser_interval)

	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	$SpawnTimer.start(spawn_timer_interval)

func _physics_process(delta):
	pass

func _on_shoot_timer_timeout():
	$AnimatedSprite2D.play("angry")
	shoot_laser()
	$ShootTimer.start(laser_interval)

func shoot_laser():
	var laser = laser_scene.instantiate()
	laser.global_position = Vector2(global_position.x+rng.randi_range(-500, 500), global_position.y+rng.randi_range(-500, 500))
	rng.randomize()
	laser.rotation = rng.randf_range(0, 2*PI)
	get_tree().current_scene.add_child(laser)

func _on_spawn_timer_timeout():
	var hp_ratio = float(health) / float(max_health)
	var spawn_count = lerp(max_spawn_count, min_spawn_count, hp_ratio)
	spawn_count = int(clamp(spawn_count, min_spawn_count, max_spawn_count))

	$AnimatedSprite2D.play("wink")
	for i in range(spawn_count):
		var index = rng.randi_range(1, 9)
		trigger_spawn(index)

	$SpawnTimer.start(spawn_timer_interval)

func trigger_spawn(index):
	var side = rng.randi_range(0, 1)
	var offset_x = -100 if side == 0 else 100
	var offset_x_alt = 100 if side == 0 else -100
	var spawn_position = global_position + Vector2(offset_x, 200)
	var spawn_position_alt = global_position + Vector2(offset_x_alt, 200)

	match index:
		1: spawn_thing_1(spawn_position)
		2: spawn_thing_2(spawn_position)
		3: spawn_thing_3(spawn_position)
		4: spawn_thing_4(spawn_position)
		5: spawn_thing_5(spawn_position, spawn_position_alt)
		6: spawn_thing_6(spawn_position, spawn_position_alt)
		7: spawn_thing_7(spawn_position)
		8: spawn_thing_8(spawn_position)
		#9: spawn_thing_9(spawn_position)

func spawn_thing_1(pos):
	var spawn = charger_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_2(pos):
	var spawn = long_shooter_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_3(pos):
	var spawn = sprinkler_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_4(pos):
	var spawn = summoner_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_5(pos, pos2):
	var enemy = enemies.pick_random().instantiate()
	enemy.global_position = pos
	get_tree().current_scene.add_child(enemy)
	enemy = enemies.pick_random().instantiate()
	enemy.global_position = pos2
	get_tree().current_scene.add_child(enemy)
func spawn_thing_6(pos, pos2):
	var enemy = charger.instantiate()
	enemy.global_position = pos
	get_tree().current_scene.add_child(enemy)
	enemy = charger.instantiate()
	enemy.global_position = pos2
	get_tree().current_scene.add_child(enemy)
func spawn_thing_7(pos):
	var spawn = exploder_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_8(pos):
	var spawn = sniper_spawn.instantiate()
	get_tree().current_scene.add_child(spawn)
func spawn_thing_9(pos): 
	pass

func _on_animated_finished() -> void:
	$AnimatedSprite2D.play("default")
