extends Node

@export var music_player : AudioStreamPlayer

var location: String
var location_music: String

func _ready():
	Global_Sound_System.set_sound_system(self)
	location = Global_Sound_System.location
	pass

func _process(delta):
	if(location != Global_Sound_System.location):
		location = Global_Sound_System.location
		update_music()
	pass

func update_music():
	location_music = str(location + "Music")
	music_player["parameters/switch_to_clip"] = location_music
