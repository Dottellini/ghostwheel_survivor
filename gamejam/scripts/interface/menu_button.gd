extends Node

enum ItemId {
	LEVEL1,
	LEVEL2,
	LEVEL3,
	LEVEL4
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = $"."
	menu.get_popup().add_item("Restart", ItemId.LEVEL1)
	menu.get_popup().add_item("To Main Menu", ItemId.LEVEL2)
	menu.get_popup().add_item("Quit", ItemId.LEVEL3)
	menu.get_popup().id_pressed.connect(_on_item_menu_pressed)


func _on_item_menu_pressed(id: int):
	match id:
		ItemId.LEVEL1:
			get_tree().change_scene_to_file("res://scenes/levels/level.tscn")
			Globaly.player = null
			Globaly.got_player = false
			Globaly.reset_global_state()
		ItemId.LEVEL2:
			get_tree().change_scene_to_file("res://scenes/interface/main_menu.tscn")
			Globaly.player = null
			Globaly.got_player = false
			Globaly.reset_global_state()
		ItemId.LEVEL3:
			get_tree().quit()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
