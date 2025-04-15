extends "res://Enemies/enemy.gd"

const bullet = preload("res://Enemies/enemy_bullet.tscn")
const OrbitingBullet = preload("res://Enemies/orbiting_bullet.tscn")

var orbit_timer := 0.0
var orbit_spawn_interval := 4.0

@export var shoot_interval_range := Vector2(1.5,3.0)

var beenTriggered := false

func _ready():
	super._ready()
	speed = 50

	beenTriggered = false
	
	orbit_timer = orbit_spawn_interval
	
	$WanderTimer.timeout.connect(_on_wander_timer_timeout)
	$WanderTimer.start(randf_range(1.0,2.0))
	
func _physics_process(delta):
	if is_player_in_range() && !beenTriggered:
		beenTriggered = true
		spawn_orbiting_bullet()

	if beenTriggered:
		velocity = get_direction_to_player() * speed
		
		orbit_timer -= delta
		if orbit_timer <= 0:
			spawn_orbiting_bullet()
			orbit_timer = orbit_spawn_interval
	
	move_and_slide()

func _on_wander_timer_timeout():
	if !beenTriggered:
		velocity = Vector2.ZERO
		$WanderTimer.start(10)
		await get_tree().create_timer(.8).timeout
		velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed
		$WanderTimer.start(randf_range(1.0, 2.5))
	
func spawn_orbiting_bullet():
	for i in range(5):
		var orb = OrbitingBullet.instantiate()
		orb.center = global_position
		orb.angle = i * (TAU/5)
		get_tree().current_scene.add_child(orb)
	
func _on_collision_area_entered(area: Area2D) -> void:
	if area.type == "friendly":
		area.kill_self()
		queue_free()
