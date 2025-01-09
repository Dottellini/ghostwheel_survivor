extends Node2D

@export var projectile_scene: PackedScene  # Die Szene für ein Projektil
@export var num_projectiles: int = 2  # Anzahl der Projektile
@export var radius: float = 100.0  # Der Radius der Kreisbahn
@export var angular_speed: float = 90.0  # Winkelgeschwindigkeit in Grad pro Sekunde
@export var cooldown: float = 240.0
@export var current_cooldown: float = 0.0

var timer = 0.0
@export var time_alive = 5 # in seconds

func _ready() -> void:
	spawn_projectiles()

func _process(delta: float) -> void:
	timer += delta
	if timer >= time_alive:
		despawn_projectiles()

func spawn_projectiles() -> void:
	for i in range(num_projectiles):
		var projectile = projectile_scene.instantiate()  # Instanziere ein Projektil
		add_child(projectile)  # Füge es als Kind hinzu
		var start_angle = i * 360.0 / num_projectiles  # Berechne den Startwinkel
		projectile.set_initial_angle(start_angle, radius, angular_speed)

func despawn_projectiles() -> void:
	for child in get_children():
		child.queue_free()
	queue_free()
