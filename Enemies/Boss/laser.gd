extends Node2D

@export var activiation = 0.5
var direction
var diminish_time : float = 0

func _ready() -> void:
	$"Time Till Death".wait_time = activiation
	$"Sprite2D".frame = 0
	$"Time Till Death".start()
	

func _on_time_till_death_timeout() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.orbit_shoot_sound)
	$Area2D.monitorable = true
	$"Sprite2D".frame = 1
	diminish_time = 1.2

func _process(delta):
	if(diminish_time > 0):
		self.scale.y = self.scale.y*min(diminish_time, 1)
		diminish_time -= delta
		if(self.scale.y<=.1):
			queue_free()
