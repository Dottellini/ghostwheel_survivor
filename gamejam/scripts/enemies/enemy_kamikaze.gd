extends "res://scripts/enemies/melee_enemy.gd"
 
func _ready() -> void:
	$AnimatedSprite2D.play("moving")
	_on_enemy_death.connect(get_tree().get_first_node_in_group("player").add_score)
	$Damage.set_monitoring(false)

	

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player") or body.is_in_group("player"):
		$Damage.set_monitoring(true)

func take_damage(damage: int) -> void:
	pass

func _on_damage_body_entered(body: Node2D) -> void:
	if body != self && !is_dying:
		$AnimatedSprite2D.queue_free()
		is_dying = true
		body.take_damage(damage)
		$ExplosionDeath.play("explosion")
		await $ExplosionDeath.animation_finished
		emit_signal("_on_enemy_death", experience)
		queue_free()
	
	
