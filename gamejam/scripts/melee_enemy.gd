extends CharacterBody2D

@onready var target = get_parent().get_node("Player")

@export var SPEED = 150.0
@export var health = 100
@export var damage = 100

var is_attacking = false
var player_body

func _physics_process(delta: float) -> void:
	if !is_attacking:
		$AnimatedSprite2D.play("moving")
	
	if health <= 0:
		$AnimatedSprite2D.play("dying")
		await get_tree().create_timer(1.0).timeout 
		queue_free()
	
	# move to Player
	if target:
		velocity = global_position.direction_to(target.global_position)
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		move_and_collide(velocity * SPEED * delta)

func enemy():
	pass

# if the enemy takes damage
func take_damage(damage: int) -> void:
	$AnimatedSprite2D.play("damaged")
	health -= damage

# if the player has entered the body
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player") and health > 0:
		is_attacking = true
		$AnimatedSprite2D.play("attacking")
		await get_tree().create_timer(1.0).timeout 
		is_attacking = false
		player_body = body
		body.take_damage(damage)
		

# cooldown for hitting of the enemy
func _on_hit_timer_timeout() -> void:
	if health > 0:
		is_attacking = true
		$AnimatedSprite2D.play("attacking")
		await get_tree().create_timer(1.0).timeout 
		is_attacking = false
		player_body.take_damage(damage)
		$Hit_Timer.start(0.5)

# if body left
func _on_hitbox_body_exited(body: Node2D) -> void:
	is_attacking = false
	$Hit_Timer.stop()
