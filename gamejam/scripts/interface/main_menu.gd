extends Node

var credit_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	get_tree().paused = false
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	credit_pos = $credits/credts_text.global_position


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


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Interface/credits.tscn")


func _on_credits_button_down() -> void:
	$credits/credts_text.global_position.y += 5


func _on_credits_button_up() -> void:
	$credits/credts_text.global_position = credit_pos


func _on_credits_mouse_exited() -> void:
	$credits/credts_text.global_position = credit_pos
