extends Area2D

signal kill

var type = "friendly_bullet"

func kill_self():
	kill.emit()
