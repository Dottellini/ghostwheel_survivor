extends Node2D
signal _collected_coin

@export var worth = 20
var glow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_collected_coin.connect(get_tree().get_first_node_in_group("player")._on_coin_pickup) # gets the player from the scene
	$Area2D/AnimatedSprite2D.play("exist")
	glow = $Area2D/glow

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	glow.rotation += deg_to_rad(5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): # if the collision is caused by the player, emit the collection signal in player
		emit_signal("_collected_coin", worth)
		queue_free()
