extends Control

var is_exiting = false
var exit_timer = 0
@onready var modulator = get_node("Dead Screen/CanvasModulate")

func _ready() -> void:
	self.position = self.position + Vector2(-750, 480)

func _on_player_room_change(direction: Variant) -> void:
	Global_Sound_System.play_sound(Global_Sound_System.door_sound)
	self.position = self.position + direction

func _process(delta: float) -> void:
	if(is_exiting):
		if (exit_timer > 0):
			modulator.color = Color(exit_timer*2, exit_timer*2, exit_timer*2, 1)
			exit_timer-= delta
		else:
			is_exiting = false
			get_tree().paused = false
			get_tree().change_scene_to_file("res://User Interface/Main Menu/MainMenu.tscn")

func _on_player_dead() -> void:
	$"Dead Screen".visible = true
	get_tree().paused = true

func _on_menu_button_pressed() -> void:
	$"Settings".visible = true
	$"Settings"._pressed_menu()

func _on_player_level_up_signal() -> void:
	$"Level Up Screen".visible = true
	$"Level Up Screen/Button"._ready()

func _on_restart_button_pressed() -> void:
	exit_timer = .5
	is_exiting = true
