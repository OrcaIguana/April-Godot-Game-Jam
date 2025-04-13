extends TileMapLayer

func _ready() -> void:
	_generate_room(Vector2i(0,0))

func _generate_room(_room_cords) -> void:
	var placement_x = 0
	var placement_y = 0
	set_cell(Vector2i(_room_cords.x+placement_x, _room_cords.y+placement_y), 0 , Vector2i(1,0))
