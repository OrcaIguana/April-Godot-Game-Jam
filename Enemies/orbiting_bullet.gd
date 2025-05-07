extends "res://Enemies/enemy_bullet.gd"

var last_position;

var orbit_radius = 40
var orbit_speed = 2 * PI
var radius_growth_rate = 50.0
var base_linear_speed = 240.0  # Pixels per second around the circle

var center = Vector2.ZERO  # center to orbit around
var center_global

var angle = 0.0
var parent : Node2D

func _ready():
	last_position = global_position
	center_global = global_position
	add_to_group("enemy_bullets")
	
func _process(delta):
	var effective_speed = orbit_speed
	if orbit_radius > 0:
			effective_speed = base_linear_speed / orbit_radius
	if(can_move):
		orbit_radius = orbit_radius + radius_growth_rate * delta
		angle += effective_speed * delta
		global_position = lerp(global_position, center + Vector2(cos(angle), sin(angle)) * orbit_radius, .01)
		direction = (global_position-last_position).normalized()
		last_position = global_position;

func update_can_move(val: bool):
	self.can_move = val

func _physics_process(delta: float) -> void:
	if(!can_move):
		velocity = base_linear_speed * direction
		move_and_slide()

func _on_bullet_collision_kill() -> void:
	remove_from_group("enemy_bullets")
	queue_free() 
