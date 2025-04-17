extends Area2D

var type = "XP"

signal kill

func kill_self():
	kill.emit()
