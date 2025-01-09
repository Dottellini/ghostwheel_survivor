extends Control

@export var shuriken_price = 100
@export var ice_bomb_price = 100
@export var ring_of_fire_price = 200

var button1
var button2
var button3
var button4
var button5
var button6
var button7
var button8

var shuriken = preload("res://scenes/weapons/shuriken/shuriken.tscn")
var ice_bomb = preload("res://scenes/weapons/ice_shot/ice_shot.tscn")
var ring_of_fire = preload("res://scenes/weapons/fireball/fireball.tscn")
var player

var shown = true
var shop_is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_is_open = true
	button1 = $background/GridContainer/Button1
	button2 = $background/GridContainer/Button2
	button3 = $background/GridContainer/Button3
	button4 = $background/GridContainer/Button4
	button5 = $background/GridContainer/Button5
	button6 = $background/GridContainer/Button6
	button7 = $background/GridContainer/Button7
	button8 = $background/GridContainer/Button8
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_manage_shop()
	$background/coin_background/coin_amount.text = "%d" % player.COINS

func _on_button_1_pressed() -> void: # buy shuriken
	if player.COINS - shuriken_price >= 0:
		Globaly.scene_list.append(shuriken)
		player.COINS -= shuriken_price
	else: _show_warning()


func _on_button_2_pressed() -> void: # buy ice bomb
	if player.COINS - ice_bomb_price >= 0:
		Globaly.scene_list.append(ice_bomb)
		player.COINS -= ice_bomb_price
	else: _show_warning()


func _on_button_3_pressed() -> void: # buy ring of fire
	if player.COINS - ring_of_fire_price >= 0:
		player.add_child(ring_of_fire.instantiate())
		player.COINS -= ring_of_fire_price
	else: _show_warning()


func _on_button_4_pressed() -> void: # buy death beam
	pass


func _on_button_5_pressed() -> void:
	pass # Replace with function body.


func _on_button_6_pressed() -> void:
	pass # Replace with function body.


func _on_button_7_pressed() -> void:
	pass # Replace with function body.


func _on_button_8_pressed() -> void:
	pass # Replace with function body.

func _manage_shop():
	if !get_tree().paused or shop_is_open:
		if Input.is_action_just_released("open_shop"):
			var ui = get_parent()
			if shown:
				shop_is_open = false
				for node in ui.get_children(false):
					if node.name != "shop":
						node.visible = true
						shown = false
					else: node.visible = false
				get_tree().paused = false
			else:
				shop_is_open = true
				for node in ui.get_children(false):
					if node.name != "shop":
						node.visible = false
						shown = true
					else: node.visible = true
				get_tree().paused = true

func _show_warning():
	var panel = $background/coin_background
	var tempStyle = panel.get_theme_stylebox("panel").duplicate()
	tempStyle.set("bg_color", Color(1.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
	await get_tree().create_timer(0.2).timeout
	tempStyle.set("bg_color", Color(0.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
	await get_tree().create_timer(0.2).timeout
	tempStyle.set("bg_color", Color(1.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
	await get_tree().create_timer(0.2).timeout
	tempStyle.set("bg_color", Color(0.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
	await get_tree().create_timer(0.2).timeout
	tempStyle.set("bg_color", Color(1.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
	await get_tree().create_timer(0.2).timeout
	tempStyle.set("bg_color", Color(0.0, 0.0, 0.0))
	panel.add_theme_stylebox_override("panel", tempStyle)
