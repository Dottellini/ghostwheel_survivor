extends Node

var is_muted = false
var is_not_user_press_of_button = false

signal _mute_sound_toggle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	get_tree().paused = false
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	
	print(Globaly.is_sound_muted)
	if Globaly.is_sound_muted == null:
		Globaly.is_sound_muted = is_muted
		set_music_player_mute()
	else:
		is_not_user_press_of_button = true # This is needed because otherwise settings the button_pressed variable will register as if the user pressed the button and change the sound
		is_muted = Globaly.is_sound_muted
		set_music_player_mute()
		$VolumeSlider/MuteButton.button_pressed = is_muted


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	

func _on_controls_button_mouse_entered() -> void:
	$Controls.show()
	

func _on_controls_button_mouse_exited() -> void:
	$Controls.hide()

func set_music_player_mute():
	if is_muted:
		$main_theme_player.stop()
	elif !is_muted:
		$main_theme_player.play()

func _on_mute_button_toggled(toggled_on: bool) -> void:
	if is_not_user_press_of_button: # See comment above to know why this is important
		is_not_user_press_of_button = false
		return
	is_muted = !is_muted
	Globaly.is_sound_muted = is_muted
	set_music_player_mute()
