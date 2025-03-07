extends Node2D

enum enemies {
	ENEMY_ONE,
	ENEMY_MAGE,
	ENEMY_KAMIKAZE_WEAK,
	ENEMY_KAMIKAZE_STRONG,
	BOSS
}

var enemy_scenes = {
	enemies.ENEMY_ONE: preload("res://scenes/Enemies/enemy_one.tscn"),
	enemies.ENEMY_MAGE: preload("res://scenes/Enemies/enemy_mage.tscn"),
	enemies.ENEMY_KAMIKAZE_WEAK: preload("res://scenes/Enemies/enemy_kamikaze_weak.tscn"),
	enemies.ENEMY_KAMIKAZE_STRONG: preload("res://scenes/Enemies/enemy_kamikaze_strong.tscn"),
	enemies.BOSS: preload("res://scenes/Enemies/enemy_boss_tengu.tscn")
}

var base_chances = {
	enemies.ENEMY_ONE: 70,
	enemies.ENEMY_MAGE: 30,
	enemies.ENEMY_KAMIKAZE_WEAK: 15,
	enemies.ENEMY_KAMIKAZE_STRONG: 5
}

@export var spawn_timestep = 0.5
@export var wave_timestep = 60 # 60
@export var initial_enemy_spawn_time = 5

var current_wave = 0
var boss_active = false  # Neue Variable, um Boss-Aktivität zu verfolgen
var current_boss = null  # Referenz auf den aktuellen Boss

var boss_wave_stop

var player_node: CharacterBody2D
var world_timer: Label
var wave_label: Label
var spawn_timer: Timer
var check_timer: Timer

func _ready() -> void:
	world_timer = $Player/UI/TimerText
	spawn_timer = $Enemy_Spawn_Timer
	wave_label = $Player/UI/WaveText
	
	spawn_timer.wait_time = initial_enemy_spawn_time
	
	check_timer = Timer.new()
	check_timer.wait_time = 1.0
	check_timer.one_shot = false
	check_timer.autostart = true
	add_child(check_timer)
	check_timer.connect("timeout", _check_condition)
	randomize()
	
func _process(delta: float) -> void:
	wave_label.text = "Difficulty: %02d" % current_wave
	
func _check_condition() -> void:
	if spawn_timer.wait_time < (spawn_timestep * 2):
		spawn_timer.wait_time = 0.1
		current_wave += 1
		#print("Check-Timer deactivated: Limit reached.")
		check_timer.stop()
		return
		
	if int(world_timer.time_elapsed) % wave_timestep == 0:
		current_wave += 1
		spawn_timer.wait_time -= spawn_timestep

		# Prüfen, ob die aktuelle Welle eine Boss-Welle ist
		if current_wave % 5 == 0:
			_spawn_boss()
		else:
			spawn_timer.start()

func spawn_item(item_type: PackedScene, position):
	var item = item_type.instantiate()
	item.position = position
	add_child(item)

func _on_enemy_spawn_timer_timeout() -> void:
	if boss_active:
		return  # Keine Gegner spawnen, wenn ein Boss aktiv ist
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$Player/Enemy_Spawn_Area/PathFollow2D.progress = rng.randi_range(0, 3962)
	var unit = pick_enemy_based_on_wave(current_wave)
	var instance = unit.instantiate()
	
	instance.global_position = $Player/Enemy_Spawn_Area/PathFollow2D/Marker2D.global_position
	add_child(instance)

func pick_enemy_based_on_wave(wave: int) -> PackedScene:
	var scaled_chances = {}
	var total_weight: float = 0.0
		
	for enemy in enemies.values():
		if enemy == enemies.BOSS:
			continue  # Normale Gegner ignorieren den Boss
		var base_chance = base_chances[enemy]
		var wave_scale = wave * 2
		scaled_chances[enemy] = base_chance + wave_scale
		total_weight += scaled_chances[enemy]
	
	for enemy in scaled_chances.keys():
		scaled_chances[enemy] = float(scaled_chances[enemy]) / total_weight * 100
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var roll = rng.randi_range(1, 100)
	var cumulative_chance = 0
	
	for enemy in scaled_chances.keys():
		cumulative_chance += scaled_chances[enemy]
		if roll <= cumulative_chance:
			return enemy_scenes[enemy]
	
	return enemy_scenes[enemies.ENEMY_ONE]

func _spawn_boss() -> void:
	if !boss_active:
		boss_active = true
		spawn_timer.stop()  # Stoppt das normale Spawnen
		boss_wave_stop=current_wave
		var boss_instance = enemy_scenes[enemies.BOSS].instantiate()
		boss_instance.global_position = $Player/Enemy_Spawn_Area/PathFollow2D/Marker2D.global_position
		add_child(boss_instance)
		current_boss = boss_instance
		
		# Signal verbinden, um Boss-Tod zu erkennen
		if boss_instance.has_signal("died"):
			boss_instance.connect("died", _on_boss_died)

func _on_boss_died() -> void:
	boss_active = false
	current_boss = null
	current_wave=boss_wave_stop
	spawn_timer.start()  # Spawnen von Gegnern fortsetzen
