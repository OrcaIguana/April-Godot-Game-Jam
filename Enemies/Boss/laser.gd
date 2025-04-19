extends Node2D

@export var activiation = 0.5
var direction

func _ready() -> void:
	$"Time Till Death".wait_time = activiation
	$"Sprite2D".frame = 0
	$"Time Till Death".start()
	

func _on_time_till_death_timeout() -> void:
	$Area2D.monitorable = true
	$"Sprite2D".frame = 1
	print("Monitorable")
