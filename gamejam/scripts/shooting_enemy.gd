extends "res://scripts/melee_enemy.gd"

var projectile_scene = preload("res://scenes/projectile_one.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hit_timer_timeout() -> void:
	pass # Replace with function body.

func shoot_projectile() -> void:
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		if projectile:
			projectile.global_position = global_position  # Assuming this script is on a Node2D
			projectile.set_direction(target.global_position - global_position)  # Ensure 'velocity' is defined
			get_tree().current_scene.add_child(projectile)
			#move_and_slide()
		else:
			print("Failed to instantiate projectile.")
	else:
		print("Projectile scene is not assigned.")

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range  = true
		velocity = Vector2(0, 0)
		$Shoot_Cooldown.start()


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = false
		velocity = global_position.direction_to(target.global_position)
		$Shoot_Cooldown.stop()


func _on_shoot_cooldown_timeout() -> void:
	shoot_projectile()
	pass
