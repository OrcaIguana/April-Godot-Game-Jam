extends Node

var room = preload("res://Dungeon testing/room.tscn")

var min_room_count = 8
var max_room_count = 12

var room_gen_chance = 25

func generate(roomseed):
	seed(roomseed)
	var dungeon = {}
	var size = randi_range(min_room_count,max_room_count)
	
	dungeon[Vector2(0,0)] = room.instance()
	size -=1
	
	while(size>0):
		for i in dungeon.keys():
			if(randf_range(0,100)<room_gen_chance):
				var room_gen_direction = randf_range(0,4)
				if(room_gen_direction < 1):
					var new_room_position = i + Vector2(1,0)
					if(!dungeon.has(new_room_position)):
						dungeon[new_room_position] = room.insance()
						size-=1
					if(dungeon.get(i).connected_rooms.get(Vector2(1, 0)) == null):
						connect_rooms(dungeon.get(i),dungeon.get(new_room_position),Vector2(1,0))
				elif(room_gen_direction < 2):
					var new_room_position = i + Vector2(-1,0)
					if(!dungeon.has(new_room_position)):
						dungeon[new_room_position] = room.insance()
						size-=1
					if(dungeon.get(i).connected_rooms.get(Vector2(1, 0)) == null):
							connect_rooms(dungeon.get(i),dungeon.get(new_room_position),Vector2(-1,0))
				elif(room_gen_direction < 3):
					var new_room_position = i + Vector2(0,1)
					if(!dungeon.has(new_room_position)):
						dungeon[new_room_position] = room.insance()
						size-=1
					if(dungeon.get(i).connected_rooms.get(Vector2(1, 0)) == null):
						connect_rooms(dungeon.get(i),dungeon.get(new_room_position),Vector2(0,1))
				elif(room_gen_direction < 4):
					var new_room_position = i + Vector2(0,-1)
					if(!dungeon.has(new_room_position)):
						dungeon[new_room_position] = room.insance()
						size-=1
					if(dungeon.get(i).connected_rooms.get(Vector2(1, 0)) == null):
							connect_rooms(dungeon.get(i),dungeon.get(new_room_position),Vector2(0,-1))
	return dungeon
func connect_rooms(room1,room2,direction):
	room1.connected_rooms[direction] = room2
	room2.connected_rooms[-direction] = room1
	room1.number_of_connections += 1
	room2.number_of_connections += 1
