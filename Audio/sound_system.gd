extends Node

@export var music_player : AudioStreamPlayer

var location: String
var location_index: int
var location_music: String

func _ready():
	Global_Sound_System.set_sound_system(self)
	location = Global_Sound_System.location
	pass

func _process(_delta):
	if(location != Global_Sound_System.location):
		location = Global_Sound_System.location
		update_music()
	pass

func update_music():
	#print("Now Playing: ", location, "Music")
	location_music = str(location + "Music")
	music_player.get_stream_playback().switch_to_clip_by_name(location_music)
	#if(location == "menu"):
		#location_index = 0
	#elif(location == "dungeon"):
		#location_index = 1
	#elif(location == "dungeon"):
		#location_index = 2
