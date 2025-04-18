extends Area2D

signal kill

var damage = 0
var type = "friendly_bullet"

func kill_self():
	kill.emit()
