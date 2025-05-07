class_name Bullet
extends CharacterBody2D

var texture = preload("res://Player/Sprites/player-bullet.png")

signal killed_enemy

# Outside info
var enemies = []
var player
var enemy_bullets = []
var nearby_enemy_bullets = []
var viewport
var viewport_position
var vx = 1920 # screen scale
var vy = 1080

# Basic attributes
var direction
var time_to_live
var waiting_to_split = false
var screen_position
var clockwise = 1
var seeking_strength = 1.0

# For timers
var can_suck = true
var can_seek = true

# For seeking
var seeking_target

# Modifiable Stats
@export_group("Bullet Stats")
@export var cooldown = 1
@export var speed = 1000
@export var lifespan = 1
@export var damage: float = 1
@export var burst = 1
@export var burst_speed = 0
@export var spread = 0
@export var splitting_angle = 0
@export var splitting_count = 0
@export var splitting_lifespan = 1
@export var stun_duration = 0
@export var sucking = 0
@export var echo_count = 0

@export_group("Bullet Modifiers")
@export var is_seeking = false
@export var is_piercing = false
@export var is_bouncing = false
@export var is_orbit = false
@export var is_echo = false
@export var is_charge = false
@export var is_spam = false
# @export var is_trail = false

var spawn_position = Vector2()

func _ready():
	add_to_group("friendly_bullets")
	$Sprite2D.texture = texture
	$"Bullet Collision".damage = damage*(max((splitting_count+1)/2.0, 1))
	viewport = get_viewport()
	viewport_position = viewport.get_canvas_transform().get_origin() - get_viewport_rect().size / 2
	enemies = get_tree().get_nodes_in_group("enemy")
	enemy_bullets = get_tree().get_nodes_in_group("enemy_bullets")
	player = get_tree().get_nodes_in_group("player")[0]
	time_to_live = lifespan
	self.global_position = spawn_position
	screen_position = self.global_position + viewport_position
	if(is_seeking):
		find_seeking_target(500)
	if(is_orbit && !is_instance_valid(seeking_target) && seeking_target != null):
		if(global_position.distance_to(seeking_target.global_position) > 500):
			speed = max(speed, 1000)
			var mouse_pos = get_global_mouse_position()
			self.global_position += self.spawn_position.direction_to(mouse_pos) * 50
			screen_position = self.global_position + viewport_position
			if((abs(self.screen_position.x) > (vx - 64) / 2) || (abs(self.screen_position.y) > (vy - 64) / 2)):
				global_position = self.global_position.move_toward(-viewport_position, 125)
	self.rotate(direction.angle())
	velocity = direction * speed
	
func _physics_process(delta: float) -> void:
	if(!bounce()):
		if(is_seeking && !is_orbit):
			update_seeking_target(500)
			if(enemies.size() > 0):
				if(is_instance_valid(seeking_target)):
					var target_direction = global_position.direction_to(seeking_target.global_position)
					rotation = lerp_angle(rotation, target_direction.angle(), 0.05*max(speed/1000.0, 2*seeking_strength))
					direction = Vector2(cos(rotation), sin(rotation))
					velocity = speed * direction
				else:
					enemies.erase(null)
		elif (is_orbit && !is_seeking):
			var target_direction = global_position.direction_to(player.global_position)
			rotation = lerp_angle(rotation, target_direction.angle()+PI/2-(clockwise*max(speed/20000, .1)), 1)
			if(clockwise == -1):
				rotation += PI
			direction = Vector2(cos(rotation), sin(rotation))
			velocity = speed * direction
		elif (is_seeking && is_orbit):
			update_seeking_target(500)
			if(seeking_target != null):
				if(enemies.size() > 0):
					if(is_instance_valid(seeking_target)):
						var target_direction = global_position.direction_to(seeking_target.global_position)
						rotation = lerp_angle(rotation, target_direction.angle(), 0.05*max(speed/1000.0, 2*seeking_strength))
						#if(clockwise == -1):
							#rotation += PI
						direction = Vector2(cos(rotation), sin(rotation))
						velocity = speed * direction
					else:
						enemies.erase(null)
			else:
				var target_direction = global_position.direction_to(player.global_position)
				rotation = lerp_angle(rotation, target_direction.angle()+PI/2-(clockwise*max(speed/20000, .1)), 1)
				if(clockwise == -1):
						rotation += PI
				direction = Vector2(cos(rotation), sin(rotation))
				velocity = speed * direction
	if(sucking != 0):
		suck()
		
	move_and_slide()
	time_to_live -= delta
	if time_to_live <= 0:
		if(sucking != 0):
			fix_suck()
		if(splitting_count > 0):
			Global_Sound_System.play_sound(Global_Sound_System.player_bullet_split_sound)
		check_split()
		

func check_split():
	if(!waiting_to_split):
		if splitting_count > 0:
			var counter = 0
			for projectile in range(self.splitting_count):
				var bullet = self.duplicate()
				if(is_orbit):
					bullet.spawn_position = self.global_position+Vector2(counter*10, counter*10)
				else:
					bullet.spawn_position = self.global_position
				bullet.lifespan = bullet.splitting_lifespan
				bullet.clockwise = self.clockwise
				bullet.seeking_strength = .2
				
				bullet.direction = self.direction.rotated(deg_to_rad(-(bullet.splitting_angle/2.0)+((bullet.splitting_angle/self.splitting_count)*(counter+.5))))
				counter += 1
				bullet.splitting_count = 0
				get_tree().current_scene.add_child(bullet)
				if(bullet.burst_speed > 0 && !is_orbit):
					waiting_to_split = true
					await get_tree().create_timer(bullet.burst_speed).timeout
					waiting_to_split = false
		#signal here to wand for splitting
		
		queue_free()


func _on_bullet_collision_kill() -> void:
	if(!is_piercing):
		queue_free()

func get_nearby_enemy_bullets(suck_distance: int) -> Array:
	enemy_bullets = get_tree().get_nodes_in_group("enemy_bullets")
	var nearby_enemy_bullets = []
	for enemy_bullet in enemy_bullets:
		if(global_position.distance_to(enemy_bullet.global_position) < suck_distance*abs(sucking)):
			nearby_enemy_bullets.append(enemy_bullet)
			enemy_bullet.update_can_move(false)
		else:
			pass
			#enemy_bullet.update_can_move(true)
	return nearby_enemy_bullets
	
func suck():
	if(can_suck):
		nearby_enemy_bullets = get_nearby_enemy_bullets(200)
		can_suck = false
		await get_tree().create_timer(0.1).timeout
		can_suck = true
	for enemy_bullet in nearby_enemy_bullets:
		if(is_instance_valid(enemy_bullet)):
			if(sucking>0):
				enemy_bullet.direction = enemy_bullet.direction.lerp(enemy_bullet.global_position.direction_to(self.global_position), sucking/20.0)
			elif(sucking < 0):
				enemy_bullet.direction = enemy_bullet.direction.lerp((enemy_bullet.global_position.direction_to(self.global_position))*-1.0, abs(sucking)/20.0)

func fix_suck():
	nearby_enemy_bullets = get_nearby_enemy_bullets(200)
	for enemy_bullet in nearby_enemy_bullets:
		if(is_instance_valid(enemy_bullet)):
			pass#enemy_bullet.can_move = true

func update_seeking_target(distance: int):
	if(can_seek):
		find_seeking_target(distance)
		can_seek = false
		await get_tree().create_timer(0.1).timeout
		can_seek = true


func find_seeking_target(distance: int) -> bool:
	enemies = get_tree().get_nodes_in_group("enemy")
	var closest_distance = 3000
	var distance_to_enemy = 0
	if(enemies.size()>0):
		for enemy in enemies:
			if(!is_instance_valid(enemy)):
				continue
			distance_to_enemy = self.global_position.distance_to(enemy.global_position)
			if(distance_to_enemy < closest_distance):
				closest_distance = distance_to_enemy
				seeking_target = enemy
			distance_to_enemy = 0
		if(seeking_target == null):
			find_seeking_target(distance)
		if(self.global_position.distance_to(seeking_target.global_position) < distance):
			return true
		else:
			#print(distance_to_enemy)
			seeking_target = null;
	else:
		return false
	return false

func bounce() -> bool:
	if(is_bouncing):
		screen_position = self.global_position + viewport_position
		if(abs(self.screen_position.x) > (vx - 64) / 2):
			if(velocity.x > 0):
				velocity.x = -abs(velocity.x)
				clockwise *= -1
			elif(velocity.x < 0):
				velocity.x = abs(velocity.x)
				clockwise *= -1
				return true
			global_position.x = min(max(global_position.x, -viewport_position.x - vx / 2 + 35), -viewport_position.x + vx / 2 - 35)
			global_position.y = min(max(global_position.y, -viewport_position.y - vy / 2 + 35), -viewport_position.y + vy / 2 - 35)
		if(abs(self.screen_position.y) > (vy - 64) / 2):
			if(velocity.y > 0):
				velocity.y = -abs(velocity.y)
				clockwise *= -1
			elif(velocity.y < 0):
				velocity.y = abs(velocity.y)
				clockwise *= -1
				return true
			global_position.x = min(max(global_position.x, -viewport_position.x - vx / 2 + 35), -viewport_position.x + vx / 2 - 35)
			global_position.y = min(max(global_position.y, -viewport_position.y - vy / 2 + 35), -viewport_position.y + vy / 2 - 35)
	return false
