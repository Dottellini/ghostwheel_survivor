extends Node

signal _on_pause
signal _on_unpause

var score: int = 0
var player: CharacterBody2D

var menu_toggled = false
var pause_manager = PauseManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()
	_on_pause.connect(get_tree().get_first_node_in_group("music")._muffle_music)
	_on_unpause.connect(get_tree().get_first_node_in_group("music")._unmuffle_music)
	for node in get_children():
		if node.name != "shop":
			node.visible = false
	await get_tree().create_timer(0.5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ScoreText.text = "Score: %d" % player.SCORE
	$coin_text.text = "Coins %d" % player.COINS


func _on_menu_button_toggled(toggled_on: bool) -> void:
	menu_toggled = !menu_toggled # freezes game when menu is opened and unfreezes when closed
	if menu_toggled: 
		emit_signal("_on_pause") # calls _on_pause in music node to muffle sound
		pause_manager.request_pause("menu_button")
	else: 
		emit_signal("_on_unpause") # undoes the muffling
		pause_manager.release_pause("menu_button")
