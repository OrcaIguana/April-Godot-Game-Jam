extends Area2D

signal kill

var type = "enemy"

func kill_self():
	kill.emit()
