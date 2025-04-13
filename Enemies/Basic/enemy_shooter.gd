extends "res://Enemies/enemy.gd"

const bullet = preload("res://Enemies/enemy_bullet.tscn")

@export var shoot_interval_range := Vector2(1.5,3.0)

var beenTriggered := false

func _ready():
	super._ready()

	beenTriggered = false
	
	$WanderTimer.timeout.connect(_on_wander_timer_timeout)
	$ShootTimer.timeout.connect(_on_shoot_timer_timeout)
	$WanderTimer.start(randf_range(1.0,2.0))
	_reset_shoot_timer()
	
func _physics_process(delta):
	if is_player_in_range():
		beenTriggered = true

	if beenTriggered:
		velocity = get_direction_to_player() * speed * .5
		$ShootTimer.timeout
	
	move_and_slide()

func _on_wander_timer_timeout():
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed
	$WanderTimer.start(randf_range(1.0, 2.5))

func _on_shoot_timer_timeout():
	if beenTriggered:
		var bullet = shoot_at_player()
		bullet.direction = get_direction_to_player().rotated(randf_range(-10,10)*(3.14/180))
		get_tree().current_scene.add_child(bullet)
	_reset_shoot_timer()

func _reset_shoot_timer():
	$ShootTimer.start(randf_range(0.2, 0.6))
	
func shoot_at_player():
	var shot = bullet.instantiate()
	shot.spawn_position = $BulletSpawnpoint.global_position
	
	return shot
	
	
	
	
