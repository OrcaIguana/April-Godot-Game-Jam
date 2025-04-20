extends "res://Enemies/enemy.gd"

const bullet = preload("res://Enemies/enemy_bullet.tscn")

enum Phase { TRIANGLE, RECTANGLE, CIRCLE }
enum Looking { LEFT, RIGHT }

@export var shoot_interval_range = Vector2(1, 1.5)

var phase = Phase.TRIANGLE
var max_health = 200
var attack_cooldown = 1.0
var shoot_cooldown = 1.0
var current_pulse_rotation = randi_range(0,360)
var looking_direction = Looking.LEFT
var animation_finished = true
var animation_looped = true

func _ready():
	super._ready()
	speed = 50
	health = max_health
	_reset_shoot_timer()

func _on_death():
	Global_Sound_System.location = "menu"
	Global_Sound_System.play_sound(Global_Sound_System.level_up_sound)
	get_tree().change_scene_to_file("res://Player/Win_Screen.tscn")
	queue_free()

func _physics_process(delta):
	check_phase_transition()
	handle_phase_behavior(delta)
	
	look_at_player()
	if phase != Phase.RECTANGLE:
		$AnimatedSprite2D.play("walk")
	else:
		if animation_looped:
			$AnimatedSprite2D.play("Laser Charge")
			animation_finished = false
	move_and_slide()

func _on_collision_area_entered(area: Area2D) -> void:
	if area.type == "friendly_bullet":
		area.kill_self()
		super.hurt(area.damage)
		check_phase_transition()

func look_at_player():
	var new_looking_direction
	var player_direction = get_direction_to_player()
	if player_direction.x > 0:
		new_looking_direction = Looking.RIGHT
	else:
		new_looking_direction = Looking.LEFT
	if new_looking_direction != self.looking_direction:
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		looking_direction = new_looking_direction

func check_phase_transition():
	if phase == Phase.TRIANGLE and health <= max_health * 0.66:
		phase = Phase.RECTANGLE
		on_rectangle_phase_start()
	elif phase == Phase.RECTANGLE and health <= max_health * 0.33:
		phase = Phase.CIRCLE
		on_circle_phase_start()

func on_rectangle_phase_start():
	speed = 0
	velocity = Vector2.ZERO

	var camera = get_viewport().get_camera_2d()
	if camera:
		global_position = camera.get_screen_center_position()
	else:
		global_position = get_tree().current_scene.get_node("Player").global_position # fallback

	attack_cooldown = 2.0

func on_circle_phase_start():
	speed = 350
	attack_cooldown = 0.0
	shoot_cooldown = 0.0


func handle_phase_behavior(delta):
	match phase:
		Phase.TRIANGLE:
			velocity = get_direction_to_player() * speed
			shoot_cooldown -= delta
			if shoot_cooldown <= 0:
				var random = randi_range(1,2)
				if random == 1:
					shoot_fragmenting_spray()
				if random == 2:
					shoot_beam()
				_reset_shoot_timer()

		Phase.RECTANGLE:
			velocity = Vector2.ZERO
			attack_cooldown -= delta
			if attack_cooldown <= 0:
				rectangle_stripe_attack()
				attack_cooldown = 3.0

		Phase.CIRCLE:
			var dir = get_direction_to_player().normalized()
			velocity = dir * speed
			attack_cooldown -= delta
			if attack_cooldown <= 0:
				pulse_attack()
				attack_cooldown = .25

func _reset_shoot_timer():
	shoot_cooldown = randf_range(shoot_interval_range.x, shoot_interval_range.y)

func pulse_attack():
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(current_pulse_rotation))
		get_tree().current_scene.add_child(shot)
		shot.speed = 200
		
		shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(current_pulse_rotation+180))
		get_tree().current_scene.add_child(shot)
		shot.speed = 200
		
		current_pulse_rotation += 30
		

func shoot_fragmenting_spray():
	for i in range(5):
		var angle = deg_to_rad(-30 + i * 15)
		var shot = bullet.instantiate()
		shot.spawn_position = $BulletSpawnpoint.global_position
		shot.direction = get_direction_to_player().rotated(angle)
		shot.speed = 600
		get_tree().current_scene.add_child(shot)
		
func shoot_beam():
	var new_direction : Vector2
	var rng = RandomNumberGenerator.new()
	for a in range(4):
		var shot_speed = 750
		rng.randomize()
		
		new_direction = Vector2(get_direction_to_player().x+rng.randf_range(-.1, .1), get_direction_to_player().y+rng.randf_range(-.1, .1))
		for i in range(10):
			var shot = bullet.instantiate()
			shot.spawn_position = $BulletSpawnpoint.global_position
			shot.direction = Vector2(0,0).direction_to(new_direction)
			shot.speed = shot_speed - 60*i
			get_tree().current_scene.add_child(shot)
		await get_tree().create_timer(.1).timeout
	rng.is_queued_for_deletion()

func rectangle_stripe_attack():
	$AnimatedSprite2D.play("Laser Attack")
	animation_looped = false
	var is_horizontal = randi() % 2 == 0
	var num_stripes = 6
	var safe_index = randi() % num_stripes
	var screen_rect = get_viewport().get_visible_rect()
	var screen_size = screen_rect.size
	var start_pos = get_viewport().get_camera_2d().get_screen_center_position() - screen_size / 2.0

	# Ensure bullets spawn at the edges
	var edge_offset = 10 # You can adjust this to control how close to the edge the bullets appear.

	for i in range(num_stripes):
		if i == safe_index:
			continue

		for j in range(6): # number of bullets per stripe
			var bullet_instance = bullet.instantiate()
			var pos := Vector2.ZERO
			var dir := Vector2.ZERO

			if is_horizontal:
				# Spawn horizontally along the top or bottom edge
				pos = Vector2(
					start_pos.x + (j * screen_size.x / 6),  # Spread across the screen width
					start_pos.y + (i + 0.5) * screen_size.y / num_stripes
				)

				# Add the offset to either the left or right edge
				if j < 3:
					pos.x -= edge_offset  # Spawn on the left edge
				else:
					pos.x += edge_offset

				dir = Vector2.RIGHT
			else:
				pos = Vector2(
					start_pos.x + (i + 0.5) * screen_size.x / num_stripes,
					start_pos.y + j * screen_size.y / 6
				)
				dir = Vector2.DOWN
				
			bullet_instance.spawn_position = pos
			bullet_instance.direction = dir

			get_tree().current_scene.add_child(bullet_instance)


func _on_animated_sprite_2d_animation_finished() -> void:
	animation_finished = true

var looped = 0
func _on_animated_sprite_2d_animation_looped() -> void:
	if looped > 1:
		animation_looped = true
		looped = 0
	else:
		looped += 1
