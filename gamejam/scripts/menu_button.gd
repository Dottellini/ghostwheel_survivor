extends Node

enum ItemId {
	LEVEL1,
	LEVEL2,
	LEVEL3
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".get_popup().add_item("Restart", ItemId.LEVEL1)
	$".".get_popup().add_item("To Main Menu", ItemId.LEVEL2)
	$".".get_popup().add_item("Quit", ItemId.LEVEL3)
	$".".get_popup().id_pressed.connect(_on_item_menu_pressed)

func _on_item_menu_pressed(id: int):
	print("Item ID: ", id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
