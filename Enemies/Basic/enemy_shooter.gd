extends "res://Enemies/enemy.gd"

@export var bullet_scene: PackedScene
@export var shoot_interval_range := Vector2(1.5,3.0)

var beenTriggered := false

func _ready():
	super._ready()

	beenTriggered = false
	
	$WanderTimer.timeout.connect(_on_wander_timer_timeout)
	$ShootTimer.timeout.connect(_on_shoot_timer_timeout)
	$WanderTimer.start(randf_range(1.0,2.0))
	_reset_shooter_timer()
	
func _physics_process(delta):
	if is_player_in_range():
		beenTriggered = true
	#else we just stay with the wander speed
	if beenTriggered:
		velocity = get_direction_to_player() * speed
	
	move_and_slide()

func _on_wander_timeout():
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed
	$WanderTimer.start(randf_range(1.0, 2.5))

func _on_shoot_timer_timeout():
	if is_player_in_range():
		shoot_at_player()
	_reset_shoot_timer()

func _reset_shoot_timer():
	$ShootTimer.start(randf_range(0.3, 0.7))
	
func shoot_at_player():
	var bullet = enemy_bullet.instantiate():
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $BulletSpawnpoint.global_position
	bullet.direction = get_direction_to_player()
	
	
	
	
