extends Area2D
@export var damage: int = 90
@export var speed: float = 300.0
var player: PackedScene = preload("res://scenes/Player.tscn")

var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")
	rotation = direction.angle()
	position += direction * speed * delta
	#if not get_viewport_rect().has_point(global_position):
		#queue_free()

func set_direction(target_direction: Vector2) -> void:
	direction = target_direction.normalized()


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):  # Beispiel: prüfe, ob das Projektil einen Feind trifft.
		body.take_damage(damage)  # Rufe eine Funktion im Feindobjekt auf.
		#queue_free()  # Entferne das Projektil.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



#func _on_timer_timeout() -> void:
	#print("Timer")
	#var instance = player.instantiate()
	#instance.shoot_projectile()
	#$Timer.start()
