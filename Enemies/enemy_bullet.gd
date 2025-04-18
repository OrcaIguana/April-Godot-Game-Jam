extends CharacterBody2D

var direction

var speed = 750
var spawn_position
var can_move = true

func _ready():
	self.global_position = spawn_position
	velocity = direction * speed
	add_to_group("enemy_bullets")

func _physics_process(delta: float) -> void:
	if(can_move):
		move_and_slide()

func update_can_move(val: bool):
	can_move = val
