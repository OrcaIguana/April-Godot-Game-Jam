class_name Bullet
extends CharacterBody2D

var direction
var time_to_live

@export_group("Bullet Stats")
@export var cooldown = 1
@export var speed = 1000
@export var lifespan = 1
@export var damage = 0
@export var burst = 1
@export var burst_speed = 0
@export var spread = 0
@export var splitting_angle = 0
@export var splitting_count = 0
@export var splitting_lifespan = 1
@export var stun_duration = 0

@export_group("Bullet Modifiers")
@export var is_seeking = false
@export var is_piercing = false
# @export var is_bouncing = false
@export var is_orbit = false
@export var is_echo = false
@export var is_charge = false
@export var is_spam = false
# @export var is_trail = false

var spawn_position = Vector2()

func _ready():
	time_to_live = lifespan
	self.global_position = spawn_position
	self.rotate(direction.angle())
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	if(is_seeking):
		pass
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0:
		if splitting_count > 0:
			var counter = 0
			for projectile in range(self.splitting_count):
				var bullet = self.duplicate()
				bullet.lifespan = splitting_lifespan
				
				bullet.direction = self.direction.rotated(deg_to_rad(-(bullet.splitting_angle/2.0)+((bullet.splitting_angle/self.splitting_count)*(counter+.5))))
				counter += 1
				bullet.spawn_position = self.global_position
				bullet.splitting_count = 0
				get_tree().current_scene.add_child(bullet)
				if(bullet.burst_speed > 0):
					await get_tree().create_timer(bullet.burst_speed).timeout
				
		#signal here to wand for splitting
		
		queue_free()


func _on_bullet_collision_kill() -> void:
	queue_free()
