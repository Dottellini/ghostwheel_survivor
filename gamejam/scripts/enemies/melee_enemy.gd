extends CharacterBody2D

@onready var target = get_parent().get_node("Player")

@export var SPEED = 150.0
@export var health = 100
@export var damage = 100
@export var experience = 100
@export var dropped_coin = preload("res://scenes/Items/small_coin_pickup.tscn")

var is_dying = false
var is_in_hitbox = false
var is_attacking = false
var is_damaged = false
var in_range = false
var has_dropped_coin = false
var player_body

signal _on_enemy_death

func _ready() -> void:
	_on_enemy_death.connect(get_tree().get_first_node_in_group("player").add_score)

func _physics_process(delta: float) -> void:
	if !is_attacking:
		$AnimatedSprite2D.play("moving")
	
	if health <= 0:
		die()
	
	# move to Player
	if target and !in_range && !is_dying:
		velocity = global_position.direction_to(target.global_position)
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		move_and_collide(velocity * SPEED * delta)

func die():
	is_dying = true
	$CollisionShape2D.set_deferred("monitoring",false)
	$AnimatedSprite2D.play("dying")
	
	if not has_dropped_coin:
		var coin = dropped_coin.instantiate()
		get_parent().add_child(coin)
		coin.position = position
		has_dropped_coin = true
	
	await get_tree().create_timer(1.0).timeout
	emit_signal("_on_enemy_death", experience)
	queue_free()

func enemy():
	pass

# if the enemy takes damage
func take_damage(damage: int) -> void:
	$AnimatedSprite2D.play("damaged")
	health -= damage

# if the player has entered the body
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player") and health > 0:
		is_in_hitbox = true
		is_attacking = true
		$AnimatedSprite2D.play("attacking")
		await get_tree().create_timer(1.0).timeout 
		is_attacking = false
		player_body = body
		body.take_damage(damage)
		$Hit_Timer.start() 

# cooldown for hitting of the enemy
func _on_hit_timer_timeout() -> void:
	if health > 0 && is_in_hitbox:
		is_attacking = true
		$AnimatedSprite2D.play("attacking")
		await get_tree().create_timer(1.0).timeout
		is_attacking = false
		player_body.take_damage(damage)
		$Hit_Timer.start(0.5)

# if body left
func _on_hitbox_body_exited(body: Node2D) -> void:
	is_in_hitbox = false
	is_attacking = false
	$Hit_Timer.stop()
