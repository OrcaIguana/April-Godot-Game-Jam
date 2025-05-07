extends Node2D

var fade_time = 3.0;
var mf;
var is_fading = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	is_fading = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_fading):
		fade_time -= delta
		mf = fade_time/3.0
		$Sprite2D.modulate = Color(mf,mf,mf, 1.0)
		if(fade_time < 0):
			get_tree().change_scene_to_file("res://User Interface/Main Menu/MainMenu.tscn")
