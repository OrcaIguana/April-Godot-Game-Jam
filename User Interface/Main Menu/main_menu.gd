extends Control

var is_fading_out = false
var fade_timer = 0.5
var fade_in = 0

@onready var modulator = get_node("Background/CanvasModulate")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	fade_in = .5
	$VBoxContainer/StartButton.grab_focus()
	if(StaticTracker.is_first_launch):
		get_tree().change_scene_to_file.call_deferred("res://User Interface/SettingsMenu.tscn")
		StaticTracker.is_first_launch = false
	Global_Sound_System.location = "menu"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(fade_in > 0):
		modulator.color = Color(1-(fade_in*2), 1-(fade_in*2), 1-(fade_in*2), 1)
		fade_in -= delta
	elif(is_fading_out):
		if (fade_timer > 0):
			modulator.color = Color(fade_timer*2, fade_timer*2, fade_timer*2, 1)
			fade_timer-= delta
		else:
			is_fading_out = false
			get_tree().change_scene_to_file("res://lvl.tscn")
			
	if Input.is_action_just_pressed("fullscreen"):
		if(DisplayServer.window_get_mode() == 3):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_position(DisplayServer.window_get_position()+Vector2i(0,20))
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_start_button_pressed() -> void:
	Global_Sound_System.play_sound(Global_Sound_System.select_sound)
	is_fading_out = true
	
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
