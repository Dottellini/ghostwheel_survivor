extends "res://scripts/weapons/melee_projectile.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$damage_area/AnimatedSprite2D.play("leer")
	$damage_area.set_deferred("monitoring",false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")
	rotation = direction.angle()
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		direction=Vector2(0,0)
		$AnimatedSprite2D.play("leer")
		$damage_area.set_deferred("monitoring",true)
		$damage_area/AnimatedSprite2D.play("default")
		await get_tree().create_timer(1.0).timeout
		queue_free()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
