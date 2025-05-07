extends Node2D

@onready var player = get_tree().current_scene.get_node("Player").get_child(0)

var spawn_position = Vector2()

var time_existing = 0.0;

var type = "XP"

signal kill

func _ready():
	self.position = spawn_position

func _on_area_2d_kill() -> void:
	queue_free()

func kill_self():
	kill.emit()
	
func _physics_process(delta: float) -> void:
	time_existing+=delta;
	global_position = global_position.lerp(player.global_position, 0.5*(time_existing/10.0))
