extends CharacterBody2D

var direction

var speed = 750
var spawn_position

func _ready():
	self.global_position = spawn_position
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
