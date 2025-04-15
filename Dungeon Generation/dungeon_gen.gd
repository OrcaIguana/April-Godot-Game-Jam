extends Node2D

# Create Array for dungeon
@export var _dimensions : Vector2i = Vector2i(6,6)
@export var _start : Vector2i = Vector2i(-1,-1)
@export var _boss_path_length : int = 9

@export var dungeon : Array

func _ready() -> void:
	_initialize_dungeon()
	_place_entrance()
	_generate_boss_path(_start , _boss_path_length)
	_print_dungeon()

func _initialize_dungeon() -> void:
	for x in _dimensions.x:
		dungeon.append([])
		for y in _dimensions.y:
			dungeon[x].append(0)

func _place_entrance() -> void:
	if _start.x < 0 or _start.x >= _dimensions.x:
		_start.x = randi_range(0 , _dimensions.x - 1)
	if _start.y < 0 or _start.y >= _dimensions.y:
		_start.y = randi_range(0 , _dimensions.y - 1)
	dungeon[_start.x][_start.y] = "S" #Spawn room

func _generate_boss_path(from : Vector2i, length : int) -> bool:
	if length == 0:
		return true
	var current : Vector2i = from
	var direction : Vector2i 
	match randi_range(0,3):
		0:
			direction = Vector2i.UP
		1:
			direction = Vector2i.RIGHT
		2:
			direction = Vector2i.DOWN
		3:
			direction = Vector2i.LEFT
	for i in 4:
		if (current.x + direction.x >= 0 and current.x + direction.x < _dimensions.x and 
			current.y + direction.y >= 0 and current.y + direction.y < _dimensions.y and 
			not dungeon[current.x + direction.x][current.y + direction.y]):
			current += direction
			dungeon[current.x][current.y] = length
			if _generate_boss_path(current, length - 1):
				return true
			else:
				dungeon[current.x][current.y] = 0
				current -= direction
		direction = Vector2(direction.y , - direction.x)
	return false


func _print_dungeon() -> void:
	var dungeon_as_string : String = ""
	for y in range(_dimensions.y - 1 , -1 , -1):
		for x in _dimensions.x:
			if dungeon[x][y]:
				dungeon_as_string += "[" + str(dungeon[x][y]) + "]" # Each dungeon room
			else:
				dungeon_as_string += "   "
		dungeon_as_string += '\n'
	print(dungeon_as_string)
