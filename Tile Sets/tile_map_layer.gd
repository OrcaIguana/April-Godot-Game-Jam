extends TileMapLayer

var _room_cords = Vector2i(0,0)
var _room_width = 28
var _room_height = 16

func _ready() -> void:
	_initialize_room()

func _make_dungeon():
	pass

func _initialize_room():
	var _tile_cords = Vector2i(0,0)
	for i in range(_room_width):
		for j in range(0,_room_height):
			set_cell(Vector2i(_room_cords.x*28+_tile_cords.x,_room_cords.y*16+_tile_cords.y),0,Vector2i(randi_range(0,2),0))
			_tile_cords += Vector2i(0,1)
		_tile_cords += Vector2i(1,0)
		_tile_cords -= Vector2i(0,_room_height)
