extends Node2D

var wand_images = [preload("res://icon.svg"), preload("res://Sprites/circle.png"), preload("res://Sprites/Slot.png")]

var bullets = preload("res://player_bullet.tscn")

func _process(delta):
	if Input.is_action_just_released("shoot"):
		shoot()

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	self.position = Vector2(0, 0)
	self.position = self.global_position.direction_to(mouse_pos) * 100

func shoot():
	var instance = bullets.instantiate()
	get_tree().current_scene.add_child(instance)
	print("Spawned Bullet")
	
