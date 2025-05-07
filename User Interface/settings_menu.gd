extends Control

@onready var music_volume_slider = get_node("VBoxContainer/MusicVolume")
@onready var sfx_volume_slider = get_node("VBoxContainer/SfxVolume")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/MusicVolume.grab_focus()
	music_volume_slider.value = Global_Sound_System.music_volume
	sfx_volume_slider.value = Global_Sound_System.sfx_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if(DisplayServer.window_get_mode() == 3):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_position(DisplayServer.window_get_position()+Vector2i(0,20))
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	pass

func _on_quit_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound, 0.5, 0.5)
	get_tree().quit()

func _on_music_volume_value_changed(value: float) -> void:
	Global_Sound_System.update_music_volume(music_volume_slider.value)
	Global_Sound_System.play_sound(Global_Sound_System.menu_sound, 2, 2)

func _on_sfx_volume_value_changed(value: float) -> void:
	Global_Sound_System.update_sfx_volume(sfx_volume_slider.value)
	Global_Sound_System.play_sound(Global_Sound_System.menu_sound, 2, 2)

func _on_hover() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.menu_sound, 1, 1)

func _on_quit_to_main_menu_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound, 1, 1)
	get_tree().change_scene_to_file("res://User Interface/Main Menu/MainMenu.tscn")
