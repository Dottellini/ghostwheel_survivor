extends "res://scripts/enemies/melee_enemy.gd"



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.take_damage(damage)
		queue_free()
