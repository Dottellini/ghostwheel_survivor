extends Node

@export var score: int
@export var time: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scoreLabel = $ScoreLabel
	var timeLabel = $TimeLabel
	
	scoreLabel.text = "Score: %d" % score
	timeLabel.text = "Time left: %02d:%02d" % [time / 60, fmod(time, 60)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_pressed() -> void:
	pass # Replace with function body.
