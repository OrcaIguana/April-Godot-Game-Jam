extends CharacterBody2D

var direction : Vector2 = Vector2(0,0)

var speed = 750
var spawn_position
var can_move = true
var lifespan = 3.0

func _ready():
	self.global_position = spawn_position
	velocity = direction * speed
	add_to_group("enemy_bullets")

func _physics_process(delta: float) -> void:
	if(!can_move):
		lifespan -= delta
		if(lifespan <0):
			_on_bullet_collision_kill()
	velocity = direction * speed
	move_and_slide()

func update_can_move(val: bool):
	can_move = val

func update_texture(new_texture: Texture2D):
	$Sprite2D.texture = new_texture

func _on_bullet_collision_kill() -> void:
	remove_from_group("enemy_bullets")
	queue_free()
