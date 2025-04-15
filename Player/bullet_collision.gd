extends Area2D

signal kill

var type = "friendly"

func kill_self():
	kill.emit()
