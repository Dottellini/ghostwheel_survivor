extends Node2D

var enemy = preload("res://scenes/enemy_one.tscn")

func _ready() -> void:
	randomize()

func _on_enemy_timer_timeout() -> void: #TODO: add connection with game scene 
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$player/Path2D/PathFollow2D.progress = rng.randi_range(0, 2555)
	var instance = enemy.instantiate()
	
	instance.global_position = $player/Path2D/PathFollow2D/Marker2D.global_position
	add_child(instance)
