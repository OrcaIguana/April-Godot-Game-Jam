extends Node

var sound_system = Node
@export var music_bus_index = AudioServer.get_bus_index("Music")
@export var sfx_bus_index = AudioServer.get_bus_index("SFX")

var sfx_players = Array()

@onready var menu_sound = preload("res://Audio/Audio_Assets/SFX/Menu.wav")
@onready var door_sound = preload("res://Audio/Audio_Assets/SFX/Door.wav")
@onready var charger_explosion_sound = preload("res://Audio/Audio_Assets/SFX/Charger_Explosion.wav")
@onready var dash_sound = preload("res://Audio/Audio_Assets/SFX/Dash.wav")
@onready var enemy_hit_sound = preload("res://Audio/Audio_Assets/SFX/Enemy_Hit.wav")
@onready var enemy_shoot_sound = preload("res://Audio/Audio_Assets/SFX/Enemy_Shoot.wav")
@onready var level_up_sound = preload("res://Audio/Audio_Assets/SFX/Level_Up.wav")
@onready var orbit_shoot_sound = preload("res://Audio/Audio_Assets/SFX/Orbit_Shoot.wav")
@onready var player_bullet_split_sound = preload("res://Audio/Audio_Assets/SFX/Player_Bullet_Split.wav")
@onready var player_hit_sound = preload("res://Audio/Audio_Assets/SFX/Player_Hit.wav")
@onready var player_shoot_sound = preload("res://Audio/Audio_Assets/SFX/Player_Shoot.wav")
@onready var select_sound = preload("res://Audio/Audio_Assets/SFX/Select.wav")
@onready var xp_pickup_sound = preload("res://Audio/Audio_Assets/SFX/XP_Pickup.wav")


var is_looping: bool
var location: String

var music_volume: float = .75
var sfx_volume: float = .75

var music_volume_multiplier: float = 1
var sfx_volume_multiplier: float = 1


func _on_ready():
	update_music_volume(.75)
	update_sfx_volume(.75)
	
func _process(_delta : float):
	pass

func set_sound_system(system : Node):
	sound_system = system
	
func update_music_volume(value : float = music_volume):
	music_volume = value
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(music_volume*music_volume_multiplier))

func update_sfx_volume(value : float = sfx_volume):
	sfx_volume = value
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(sfx_volume*sfx_volume_multiplier))

func play_sound(sound : AudioStream, pitch_min : float = .9, pitch_max : float = 1.1):
	var found_sound = false
	var target_player : AudioStreamPlayer
	for player in sfx_players:
		if(player.stream == sound):
			target_player = player
			found_sound = true
			break
	if(!found_sound):
		print("Making new audio player for: ", var_to_str(sound))
		var new_player = AudioStreamPlayer.new()
		new_player.bus = "SFX"
		new_player.volume_db=-20
		new_player.max_polyphony = 3
		sfx_players.append(new_player)
		sound_system.add_child(new_player)
		target_player = new_player
		target_player.set_stream(sound)
	target_player.pitch_scale = randf_range(pitch_min, pitch_max)
	target_player.play()
