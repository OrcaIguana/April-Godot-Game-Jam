extends Node2D

var orbit_radius = 40
var orbit_speed = 2 * PI
var radius_growth_rate = 50.0
var base_linear_speed = 240.0  # Pixels per second around the circle

var center = Vector2.ZERO  # center to orbit around

var angle = 0.0
var parent : Node2D

func _process(delta):
	var effective_speed = orbit_speed
	if orbit_radius > 0:
		effective_speed = base_linear_speed / orbit_radius
	angle += effective_speed * delta
	orbit_radius = orbit_radius + radius_growth_rate * delta
	global_position = center + Vector2(cos(angle), sin(angle)) * orbit_radius


func _on_bullet_collision_kill() -> void:
	queue_free() 
