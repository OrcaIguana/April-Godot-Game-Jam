extends CharacterBody2D

const bullet = preload("res://Enemies/enemy_bullet.tscn")

var resting := false

var speed

var acceleration = 20

func _ready():	
	$Sprite2D.play("default")
	speed = 150
	$ChargeTimer.timeout.connect(_on_charge_timer_timeout)
	_reset_charge_timer()
	
func _physics_process(_delta):

	if !resting:
		velocity += get_direction_to_player() * acceleration
	
	move_and_slide()

func _on_charge_timer_timeout():
	spawn_bullet_burst()
	velocity = Vector2.ZERO
	resting = true
	$WanderTimer.start(10)
	await get_tree().create_timer(.8).timeout
	$Sprite2D.play("Getting Ready")
	$Sprite2D.rotation = get_direction_to_player().angle() - PI
	velocity = get_direction_to_player() * speed
	resting = false
	_reset_charge_timer()


func _reset_charge_timer():
	$ChargeTimer.start(1)
	
func spawn_bullet_burst():
	$Sprite2D.play("Explode")
	for i in range(4):
		var shot = bullet.instantiate()
		shot.spawn_position = self.global_position
		shot.direction = Vector2.LEFT.rotated(deg_to_rad(i*90))
		shot.speed = 800
		get_tree().current_scene.add_child(shot)

func get_direction_to_player() -> Vector2:
	return (get_tree().get_first_node_in_group("player").global_position - global_position).normalized()

func _on_sprite_2d_animation_finished() -> void:
	if($Sprite2D.animation == "Getting Ready"):
		$Sprite2D.play("Moving")
	elif($Sprite2D.animation == "Explode"):
		$Sprite2D.play("default")
