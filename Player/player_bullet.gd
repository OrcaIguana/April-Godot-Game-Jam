extends CharacterBody2D

var direction

@export var speed = 1000
var spawn_position = Vector2()
var time_to_live = 0

func _ready():
	self.global_position = spawn_position
	self.rotate(direction.angle())
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()
