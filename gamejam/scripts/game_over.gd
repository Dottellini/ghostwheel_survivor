extends Node

@export var score: int
@export var time: float

var scoreLabel
var timeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreLabel = $ScoreLabel
	timeLabel = $TimeLabel
	
	var player = get_parent()
	player._on_death.connect(_show_screen)

func _show_screen():
	$".".visible = true
	
	score = get_parent().SCORE
	time = get_parent().get_node("UI/TimerText").time_elapsed
	
	scoreLabel.text = "Score: %d" % score
	timeLabel.text = "Time survived: %02d:%02d:%02d" % [time / 60 / 60, fmod(time / 60,  60), fmod(time, 60)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
