extends Area2D

signal kill

var type = "enemy_bullet"

func kill_self():
	kill.emit()
