extends Node2D
signal _collected_gambling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_collected_gambling.connect(get_tree().get_first_node_in_group("player")._on_gambling_pickup) # gets the player from the scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): # if the collision is caused by the player, emit the collection signal in player
		$Area2D/AnimatedSprite2D.play("chest_open")
		emit_signal("_collected_gambling")
		queue_free()
