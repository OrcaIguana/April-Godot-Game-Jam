extends CharacterBody2D

var direction

@export var speed = 1000

func _ready():
	var mouse_pos = get_viewport().get_mouse_position()
	direction = global_position.direction_to(mouse_pos)
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
