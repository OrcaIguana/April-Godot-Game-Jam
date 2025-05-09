extends "res://Enemies/enemy.gd"

const bullet = preload("res://Enemies/enemy_bullet.tscn")

var beenTriggered := false
var resting := false

var acceleration = 20

func _ready():
	super._ready()
	
	speed = 200
	
	health = 1
	
	follow_distance = 250

	beenTriggered = false
	
	$WanderTimer.timeout.connect(_on_wander_timer_timeout)
	$ChargeTimer.timeout.connect(_on_charge_timer_timeout)
	$WanderTimer.start(randf_range(1.0,2.0))
	_reset_charge_timer()
	
func _physics_process(_delta):
	if is_player_in_range():
		beenTriggered = true
		$AnimatedSprite2D.play("Getting Ready")
		$AnimatedSprite2D.rotation = deg_to_rad(get_direction_to_player().angle())

	if beenTriggered && !resting:
		$AnimatedSprite2D.play("Moving")
		velocity += get_direction_to_player() * acceleration
		$AnimatedSprite2D.rotation = get_direction_to_player().angle() - PI
	
	move_and_slide()

func _on_wander_timer_timeout():
	if !beenTriggered:
		velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed
		$WanderTimer.start(randf_range(1.0, 2.5))

func _on_charge_timer_timeout():
	if beenTriggered:
		spawn_bullet_burst()
	velocity = Vector2.ZERO
	resting = true
	$WanderTimer.start(10)
	await get_tree().create_timer(.8).timeout
	velocity = get_direction_to_player() * speed
	resting = false
	_reset_charge_timer()


func _reset_charge_timer():
	$ChargeTimer.start(1)
	
func spawn_bullet_burst():
	$AnimatedSprite2D.play("Explode")
	Global_Sound_System.play_sound(Global_Sound_System.charger_explosion_sound)
	for i in range(12):
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(i*30))
		shot.speed = 200
		get_tree().current_scene.add_child(shot)
	for i in range(8):
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(i*45))
		shot.speed = 400
		get_tree().current_scene.add_child(shot)
	for i in range(4):
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(i*90))
		shot.speed = 800
		get_tree().current_scene.add_child(shot)
	queue_free()

func _on_collision_area_entered(area: Area2D) -> void:
	if area.type == "friendly_bullet":
		area.kill_self()
		super.hurt(area.damage)
	else:
		pass
