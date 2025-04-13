extends CharacterBody2D

var direction

@export var speed = 1000
var spawn_position = Vector2()
var time_to_live = 1

func _ready():
	self.global_position = spawn_position
	var mouse_pos = get_viewport().get_mouse_position()
	direction = global_position.direction_to(mouse_pos)
	self.rotate(direction.angle())
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
	print(time_to_live)
	print(delta)
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()
