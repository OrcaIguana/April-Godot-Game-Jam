extends CharacterBody2D

var direction

@export_group("Bullet Stats")
@export var speed = 1000
@export var time_to_live = 0
@export var damage = 0
@export var burst = 0
@export var burst_speed = 0
@export var spread = 0
@export var knockback = 0

@export_group("Bullet Modifiers")
@export var is_seeking = false
@export var is_piercing = false
@export var is_bouncing = false
@export var is_slowing = false
@export var is_splitting = false
@export var is_orbit = false
@export var is_echo = false
@export var is_charge = false
@export var is_spam = false
@export var is_trail = false

var spawn_position = Vector2()

func load_modifiers(modifiers: Array):
	return

func _ready():
	self.global_position = spawn_position
	self.rotate(direction.angle())
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()
