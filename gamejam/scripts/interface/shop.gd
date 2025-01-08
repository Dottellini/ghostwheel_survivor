extends Control

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

var shown = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button1 = $background/GridContainer/Button1
	button2 = $background/GridContainer/Button2
	button3 = $background/GridContainer/Button3
	button4 = $background/GridContainer/Button4
	button5 = $background/GridContainer/Button5
	button6 = $background/GridContainer/Button6
	button7 = $background/GridContainer/Button7
	button8 = $background/GridContainer/Button8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_manage_shop()

func _on_button_1_pressed() -> void: # buy shuriken
	Globaly.scene_list.append(shuriken)


func _on_button_2_pressed() -> void: # buy ice bomb
	Globaly.scene_list.append(ice_bomb)


func _on_button_3_pressed() -> void: # buy ring of fire
	get_tree().get_first_node_in_group("player").add_child(ring_of_fire.instantiate())


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
	if Input.is_action_just_released("open_shop"):
		var ui = get_parent()
		
		if shown:
			for node in ui.get_children(false):
				if node.name != "shop":
					node.visible = true
					shown = false
				else: node.visible = false
			get_tree().paused = false
		else:
			for node in ui.get_children(false):
				if node.name != "shop":
					node.visible = false
					shown = true
				else: node.visible = true
			get_tree().paused = true
