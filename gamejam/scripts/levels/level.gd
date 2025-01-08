extends Node2D

var enemy = preload("res://scenes/Enemies/enemy_one.tscn")
var enemy2 = preload("res://scenes/Enemies/enemy_mage.tscn")

# 0.5 and 50 takes 10 minutes until youre at max wave
@export var spawn_timestep = 0.5
@export var wave_timestep = 60

var current_wave = 0

var player_node: CharacterBody2D
var world_timer: Label
var wave_label: Label
var spawn_timer: Timer
var check_timer: Timer

var enemy_list = []

func _ready() -> void:
	enemy_list.append(enemy)
	enemy_list.append(enemy2)
	
	world_timer = $Player/UI/TimerText
	spawn_timer = $Enemy_Spawn_Timer
	wave_label = $Player/UI/WaveText
	
	# Timer für die Bedingung hinzufügen
	check_timer = Timer.new()
	check_timer.wait_time = 1.0  # Prüft alle 1 Sekunde
	check_timer.one_shot = false
	check_timer.autostart = true
	add_child(check_timer)

	check_timer.connect("timeout", _check_condition)
	
	get_tree().paused = false # makes sure game is not paused when starting level
	randomize()
	
func _process(delta: float) -> void:
	wave_label.text = "Wave: %02d" % current_wave
	
func _check_condition() -> void:
	if spawn_timer.wait_time < (spawn_timestep * 2):
		spawn_timer.wait_time = 0.1
		current_wave += 1
		print("Check-Timer deactivated: Limit reached.")
		check_timer.stop()  # Deaktiviert den Check-Timer
		return
		
	
	if (int(world_timer.time_elapsed) % wave_timestep == 0):
		current_wave += 1
		spawn_timer.wait_time -= spawn_timestep


func _on_enemy_spawn_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$Player/Enemy_Spawn_Area/PathFollow2D.progress = rng.randi_range(0, 3962)
	var unit = enemy_list.pick_random()
	var instance = unit.instantiate()
	
	instance.global_position = $Player/Enemy_Spawn_Area/PathFollow2D/Marker2D.global_position
	add_child(instance)
