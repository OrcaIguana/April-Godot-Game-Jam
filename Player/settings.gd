extends Control

@onready var music_volume_slider = get_node("VBoxContainer/MusicVolume")
@onready var sfx_volume_slider = get_node("VBoxContainer/SfxVolume")

var ready_for_input = .1

# Called when the node enters the scene tree for the first time.
func _pressed_menu() -> void:
	ready_for_input = .1
	$VBoxContainer/MusicVolume.grab_focus()
	Global_Sound_System.music_volume_multiplier = .33
	Global_Sound_System.update_music_volume()
	music_volume_slider.value = Global_Sound_System.music_volume
	sfx_volume_slider.value = Global_Sound_System.sfx_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ready_for_input -= delta
	if(ready_for_input < 0):
		if(Input.is_action_just_pressed("menu")):
			_on_back_button_pressed()

func _on_back_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound, 1, 1)
	Global_Sound_System.music_volume_multiplier = 1
	Global_Sound_System.update_music_volume()
	self.visible = false
	get_tree().paused = false

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
	Global_Sound_System.location = "menu"
	Global_Sound_System.music_volume_multiplier = 1
	Global_Sound_System.update_music_volume()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://User Interface/Main Menu/MainMenu.tscn")

func _on_sfx_volume_focus_exited() -> void:
	pass
