extends Node2D

var x
var y

var id

func _ready() -> void:
	self.position = Vector2(x * 1930, y * 1100)

func disable_doors(disable_list):
	if disable_list == null:
		return
	for doors in disable_list:
		match doors:
			"UP":
				$Door.visible = false
				$Door.monitorable = false
				$Door.monitoring = false
			"RIGHT":
				$Door2.visible = false
				$Door2.monitorable = false
				$Door2.monitoring = false
			"DOWN":
				$Door3.visible = false
				$Door3.monitorable = false
				$Door3.monitoring = false
			"LEFT":
				$Door4.visible = false
				$Door4.monitorable = false
				$Door4.monitoring = false
