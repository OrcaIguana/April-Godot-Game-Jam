extends Control

var is_fading = false
var fade_timer = 0.5
@onready var modulator = get_node("Background/CanvasModulate")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()
	Global_Sound_System.location = "menu"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_fading):
		if (fade_timer > 0):
			modulator.color = Color(fade_timer*2, fade_timer*2, fade_timer*2, 1)
			fade_timer-= delta
		else:
			is_fading = false
			get_tree().change_scene_to_file("res://lvl.tscn")

func _on_start_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	is_fading = true
	
func _on_settings_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	get_tree().change_scene_to_file("res://User Interface/SettingsMenu.tscn")
	
func _on_quit_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	get_tree().quit()

func _on_test_scene_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	get_tree().change_scene_to_file("res://testlvl.tscn")

func _on_hover():
		Global_Sound_System.play_sound(Global_Sound_System.menu_sound, 1, 1)
