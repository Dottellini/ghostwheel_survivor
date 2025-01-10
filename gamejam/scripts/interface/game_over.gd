extends Node
signal muffle

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
	
	muffle.connect(get_tree().get_first_node_in_group("music")._muffle_music)

func _show_screen():
	$".".visible = true
	
	score = get_parent().SCORE
	time = get_parent().get_node("UI/TimerText").time_elapsed
	
	scoreLabel.text = "Score: %d" % score
	timeLabel.text = "Time survived: %02d:%02d:%02d" % [time / 60 / 60, fmod(time / 60,  60), fmod(time, 60)]
	
	emit_signal("muffle")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	PauseManager.clear_requests()
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")
	

func _on_main_menu_pressed() -> void:
	Globaly.player = null
	Globaly.got_player = false
	Globaly.reset_global_state()
	get_tree().change_scene_to_file("res://scenes/interface/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
