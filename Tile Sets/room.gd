extends Node2D

var x
var y

var disable = false
var unlocked = false

var enemy_shooter = preload("res://Enemies/Basic/enemy_shooter.tscn")
var enemy_orbit = preload("res://Enemies/Basic/enemy_orbit.tscn")
var enemy_charger = preload("res://Enemies/Basic/enemy_charger.tscn")
var enemy_random = preload("res://Enemies/Basic/enemy_random.tscn")

var open_door = preload("res://Tile Sets/Wall Tiles/pathway-open.png")
var closed_door = preload("res://Tile Sets/Wall Tiles/pathway-closed.png")

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

func _process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("enemy") == 0 and disable == true and unlocked == false:
		unlock()
		unlocked = true

func spawn_enemies(difficulty):
	var spawnpoints = [$"Spawn Point", $"Spawn Point2", $"Spawn Point3", $"Spawn Point4",
	 $"Spawn Point5", $"Spawn Point6", $"Spawn Point7", $"Spawn Point8", $"Spawn Point9",
	 $"Spawn Point10", $"Spawn Point11"]
	
	if(id == 1):
		spawnpoints.remove_at(6)
	
	var spawn_credits = difficulty + randi_range(0, id/2)
	
	var new_enemies = []
	
	while spawn_credits > 0:
		match randi_range(0,3):
			0:
				new_enemies.append(enemy_random.instantiate())
				spawn_credits -= 1
			1:
				new_enemies.append(enemy_charger.instantiate())
				spawn_credits -= 1
			2:
				new_enemies.append(enemy_orbit.instantiate())
				spawn_credits -= 1
			3:
				new_enemies.append(enemy_shooter.instantiate())
				spawn_credits -= 1
				
	for enemy in new_enemies:
		enemy.spawn_location = spawnpoints[randi_range(0, len(spawnpoints)-1)].global_position
		call_deferred("add_child", enemy)
	
func lock():
	var doors = [$Door, $Door2, $Door3, $Door4]
	for door in doors:
		if door.visible:
			door.old_type = door.type
			door.type = "locked"
			door.get_node("Sprite2D").texture = closed_door
		
func unlock():
	Global_Sound_System.play_sound(Global_Sound_System.door_sound, 2, 2)
	var doors = [$Door, $Door2, $Door3, $Door4]
	for door in doors:
		if door.visible:
			door.type = door.old_type
			door.get_node("Sprite2D").texture = open_door

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.type == "friendly":
		if not disable:
			lock()
			spawn_enemies(id)
			disable = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if(area.type != null):
		if(area.type == "enemy_bullet" || area.type == "friendly_bullet"):
			area.kill_self()
