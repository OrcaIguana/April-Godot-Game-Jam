class_name Bullet
extends CharacterBody2D

signal killed_enemy

var enemies = []
var player

var direction
var time_to_live
var waiting_to_split = false

var seeking_target

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
	enemies = get_tree().get_nodes_in_group("enemy")
	player = get_tree().get_nodes_in_group("player")[0]
	time_to_live = lifespan
	self.global_position = spawn_position
	if(is_seeking):
		find_seeking_target(2000)
	if(is_orbit):
		speed = max(speed, 1000)
		var mouse_pos = get_viewport().get_mouse_position()
		self.global_position += self.spawn_position.direction_to(mouse_pos) * 50
	self.rotate(direction.angle())
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	if(is_seeking && !is_orbit):
		if(enemies.size() > 0):
			if(is_instance_valid(seeking_target)):
				var target_direction = global_position.direction_to(seeking_target.global_position)
				rotation = lerp_angle(rotation, target_direction.angle(), 0.05*max(speed/1000.0, 2))
				direction = Vector2(cos(rotation), sin(rotation))
				velocity = speed * direction
			else:
				enemies.erase(null)
	elif (is_orbit && !is_seeking):
		var target_direction = global_position.direction_to(player.global_position)
		rotation = lerp_angle(rotation, target_direction.angle()+PI/2, 1)
		direction = Vector2(cos(rotation), sin(rotation))
		velocity = speed * direction
	elif (is_seeking && is_orbit):
		if(find_seeking_target(500)):
			if(is_instance_valid(seeking_target)):
				var target_direction = global_position.direction_to(seeking_target.global_position)
				rotation = lerp_angle(rotation, target_direction.angle(), 0.05*max(speed/1000.0, 2))
				direction = Vector2(cos(rotation), sin(rotation))
				velocity = speed * direction
		else:
			var target_direction = global_position.direction_to(player.global_position)
			rotation = lerp_angle(rotation, target_direction.angle()+PI/2, 1)
			direction = Vector2(cos(rotation), sin(rotation))
			velocity = speed * direction
	
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0 && !waiting_to_split:
		if splitting_count > 0:
			var counter = 0
			for projectile in range(self.splitting_count):
				var bullet = self.duplicate()
				bullet.spawn_position = self.global_position
				bullet.lifespan = bullet.splitting_lifespan
				
				bullet.direction = self.direction.rotated(deg_to_rad(-(bullet.splitting_angle/2.0)+((bullet.splitting_angle/self.splitting_count)*(counter+.5))))
				counter += 1
				bullet.splitting_count = 0
				get_tree().current_scene.add_child(bullet)
				if(bullet.burst_speed > 0):
					waiting_to_split = true
					await get_tree().create_timer(bullet.burst_speed).timeout
					waiting_to_split = false
		#signal here to wand for splitting
		queue_free()


func _on_bullet_collision_kill() -> void:
	queue_free()

func find_seeking_target(distance: int) -> bool:
	var closest_distance = distance
	var distance_to_enemy = distance
	if(enemies.size()>0):
		for enemy in enemies:
			if(!is_instance_valid(enemy)):
				continue
			distance_to_enemy = position.distance_to(enemy.position)
			if(distance_to_enemy < closest_distance):
				closest_distance = distance_to_enemy
				seeking_target = enemy
		if(distance_to_enemy < distance):
			return true
		else:
			seeking_target = null;
	else:
		return false
	return false
