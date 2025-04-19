extends Node2D

@export var activiation = 0.5
var direction

func _ready() -> void:
	$"Time Till Death".wait_time = activiation
	$"Polygon2D".visible = false
	$"Time Till Death".start()
	

func _on_time_till_death_timeout() -> void:
	$Area2D.monitorable = true
	$"Polygon2D".visible = true
	print("Monitorable")
