extends Node2D

@export var projectile_scene: PackedScene  # Die Szene für ein Projektil
@export var num_projectiles: int = 10  # Anzahl der Projektile
@export var radius: float = 10.0  # Der Radius der Kreisbahn
@export var angular_speed: float = 90.0  # Winkelgeschwindigkeit in Grad pro Sekunde

var timer = 0.0
var alive = true
@export var time_alive = 5 # in seconds
@export var time_dead = 5 # in seconds

func _ready() -> void:
	spawn_projectiles()
	alive = true

func _process(delta: float) -> void:
	timer += delta
	if alive:
		if timer >= time_alive:
			set_dead()
	else:
		if timer >= time_dead:
			set_alive()

func set_alive():
	spawn_projectiles()
	alive = true
	timer = 0.0
	
func set_dead():
	despawn_projectiles()
	alive = false
	timer = 0.0	

func spawn_projectiles() -> void:
	for i in range(num_projectiles):
		var projectile = projectile_scene.instantiate()  # Instanziere ein Projektil
		add_child(projectile)  # Füge es als Kind hinzu
		var start_angle = i * 360.0 / num_projectiles  # Berechne den Startwinkel
		projectile.set_initial_angle(start_angle, radius, angular_speed)

func despawn_projectiles() -> void:
	for child in get_children():
		child.queue_free()
		
	
