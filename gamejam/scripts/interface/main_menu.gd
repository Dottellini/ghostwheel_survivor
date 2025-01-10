extends Node

var is_muted = false
signal _mute_sound_toggle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	get_tree().paused = false
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	Globaly.is_sound_muted = is_muted


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

func _on_mute_button_toggled(toggled_on: bool) -> void:
	is_muted = !is_muted
	Globaly.is_sound_muted = is_muted
	if is_muted and $main_theme_player.playing:
		$main_theme_player.stop()
	elif !is_muted and !$main_theme_player.playing:
		$main_theme_player.play()
