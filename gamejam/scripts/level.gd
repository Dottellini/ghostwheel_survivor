extends Node2D

var enemy = preload("res://scenes/Enemies/enemy_one.tscn")
var enemy2 = preload("res://scenes/Enemies/enemy_mage.tscn")

var enemy_list = []

func _ready() -> void:
	enemy_list.append(enemy)
	enemy_list.append(enemy2)
	get_tree().paused = false # makes sure game is not paused when starting level
	randomize()


func _on_enemy_spawn_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$Player/Enemy_Spawn_Area/PathFollow2D.progress = rng.randi_range(0, 3962)
	var unit = enemy_list.pick_random()
	var instance = unit.instantiate()
	
	instance.global_position = $Player/Enemy_Spawn_Area/PathFollow2D/Marker2D.global_position
	add_child(instance)
