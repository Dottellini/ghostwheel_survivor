extends Node

var is_muted = false
var is_not_user_press_of_button = false
var credit_pos

var pause_manager = PauseManager

signal _mute_sound_toggle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	pause_manager.clear_requests()
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	credit_pos = $credits/credits_text.global_position

	
	if Globaly.is_sound_muted == null:
		Globaly.is_sound_muted = is_muted
		set_music_player_mute()
	else:
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
	is_muted = toggled_on
	Globaly.is_sound_muted = is_muted
	set_music_player_mute()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Interface/credits.tscn")


func _on_credits_button_down() -> void:
	$credits/credits_text.global_position.y += 5


func _on_credits_button_up() -> void:
	$credits/credits_text.global_position = credit_pos


func _on_credits_mouse_exited() -> void:
	$credits/credits_text.global_position = credit_pos
