extends Node2D

var x
var y

var disable = false

var id

func _ready() -> void:
	self.position = Vector2(x * 2000, y * 1200)

func add_doors(add):
	for additions in add:
		if additions == "UP":
			$Door.visible = true
			$Door.monitorable = true
			$Door.monitoring = true
		if additions == "RIGHT":
			$Door2.visible = true
			$Door2.monitorable = true
			$Door2.monitoring = true
		if additions == "DOWN":
			$Door3.visible = true
			$Door3.monitorable = true
			$Door3.monitoring = true
		if additions == "LEFT":
			$Door4.visible = true
			$Door4.monitorable = true
			$Door4.monitoring = true

func _process(delta: float) -> void:
	if get_tree().get_node_count_in_group("enemy") == 0 and disable == true:
		unlock()
		

func lock():
	var doors = [$Door, $Door2, $Door3, $Door4]
	for door in doors:
		if door.visible:
			door.old_type = door.type
			door.type = "locked"
		
func unlock():
	var doors = [$Door, $Door2, $Door3, $Door4]
	for door in doors:
		if door.visible:
			door.type = door.old_type

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.type == "friendly":
		if not disable:
			lock()
			disable = true
