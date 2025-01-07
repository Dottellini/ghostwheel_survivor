extends Node

var score: int = 0
var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ScoreText.text = "Score: %d" % player.SCORE


func _on_menu_button_toggled(toggled_on: bool) -> void:
	get_tree().paused = !get_tree().paused # freezes game when menu is opened and unfreezes when closed
