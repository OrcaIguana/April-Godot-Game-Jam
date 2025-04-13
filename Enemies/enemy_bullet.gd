extends CharacterBody2D

var direction

@export var speed = 500
var spawn_position
var time_to_live = 1

func _ready():
	self.global_position = spawn_position
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
	print(time_to_live)
	print(delta)
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()
