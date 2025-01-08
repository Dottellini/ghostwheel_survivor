extends "res://scripts/weapons/melee_projectile.gd"




func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.take_damage(damage)
