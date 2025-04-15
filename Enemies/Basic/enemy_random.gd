extends "res://Enemies/enemy.gd"

const bullet = preload("res://Enemies/enemy_bullet.tscn")

@export var shoot_interval_range := Vector2(1.5,3.0)

var beenTriggered := false

func _ready():
	super._ready()
	speed = 200

	beenTriggered = false
	
	$WanderTimer.timeout.connect(_on_wander_timer_timeout)
	$ShootTimer.timeout.connect(_on_shoot_timer_timeout)
	$WanderTimer.start(randf_range(1.0,2.0))
	_reset_shoot_timer()
	
func _physics_process(delta):
	if is_player_in_range():
		beenTriggered = true
	
	move_and_slide()

func _on_wander_timer_timeout():
	if !beenTriggered:
		velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed
		$WanderTimer.start(randf_range(1.0, 2.5))
	else:
		var random_vec = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * 0.75
		var player_vec = get_direction_to_player() * 1.5
		velocity = (random_vec + player_vec).normalized() * speed
		$WanderTimer.start(randf_range(1.0, 2.5))

func _on_shoot_timer_timeout():
	if beenTriggered:
		await shoot_at_player()
	_reset_shoot_timer()

func _reset_shoot_timer():
	$ShootTimer.start(randf_range(0.8, 1))
	
func shoot_at_player():
	var bullet_selector = randi_range(1,4)
	if bullet_selector == 1:
		for i in range(3):
			var shot = bullet.instantiate()
			shot.spawn_position = $BulletSpawnpoint.global_position
			shot.direction = get_direction_to_player().rotated(deg_to_rad(-15+i*15))
			shot.speed = 600
			get_tree().current_scene.add_child(shot)
			await get_tree().create_timer(.1).timeout
	if bullet_selector == 2:
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = get_direction_to_player()
		shot.speed = 650
		shot.apply_scale(Vector2(2.5, 2.5))
		get_tree().current_scene.add_child(shot)
	if bullet_selector == 3:
		for i in range(8):
			var shot = bullet.instantiate()
			shot.spawn_position = $BulletSpawnpoint.global_position
			shot.direction = Vector2.LEFT.rotated(deg_to_rad(i*45))
			shot.speed = 300
			get_tree().current_scene.add_child(shot)


func _on_collision_area_entered(area: Area2D) -> void:
	if area.type == "friendly":
		area.kill_self()
		queue_free()
