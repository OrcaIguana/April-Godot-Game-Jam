extends CharacterBody2D

@export var speed = 500

func get_input():
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
