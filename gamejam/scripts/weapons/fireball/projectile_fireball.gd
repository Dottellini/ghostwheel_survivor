extends Area2D

@export var damage: int = 200
var angle: float = 0.0
var radius: float = 100.0
var angular_speed: float = 90.0

func set_initial_angle(start_angle: float, circle_radius: float, speed: float) -> void:
	angle = start_angle
	radius = circle_radius
	angular_speed = speed

func _process(delta: float) -> void:
	angle += angular_speed * delta
	angle = fmod(angle, 360)  # Winkel innerhalb von 0-360 Grad halten
	position = Vector2(
		radius * cos(deg_to_rad(angle)),
		radius * sin(deg_to_rad(angle))
	)
	
func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):  # Beispiel: prüfe, ob das Projektil einen Feind trifft.
		body.take_damage(damage)  # Rufe eine Funktion im Feindobjekt auf.
		queue_free()  # Entferne das Projektil.
