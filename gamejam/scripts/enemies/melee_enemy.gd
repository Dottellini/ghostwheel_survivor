extends CharacterBody2D

@onready var target = get_parent().get_node("Player")

@export var SPEED = 150.0
@export var health = 100
@export var damage = 100
@export var experience = 100
@export var dropped_coin = preload("res://scenes/Items/small_coin_pickup.tscn")

var health_item = preload("res://scenes/Items/health_item.tscn")
@export var health_drop_chance = 0.015 # 1.5% drop chance

var is_dying = false
var is_in_hitbox = false
var is_attacking = false
var is_damaged = false
var in_range = false
var has_dropped_coin = false
var player_body

signal _on_enemy_death

func _ready() -> void:
	randomize()
	$AnimatedSprite2D.play("moving")
	_on_enemy_death.connect(get_tree().get_first_node_in_group("player").add_score)

func _physics_process(delta: float) -> void:
	if !is_attacking && !is_dying:
		$AnimatedSprite2D.play("moving")
	
	if health <= 0 and !is_dying: # without checking for is_dying, the die() function is called every frame
		die()
	
	# move to Player
	if target and !in_range and !is_dying:
		velocity = global_position.direction_to(target.global_position)
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		move_and_collide(velocity * SPEED * delta)

func die():
	is_dying = true
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimatedSprite2D.play("dying")
	
	if self.has_node("Mage_Dying"):
		$Mage_Dying.play("dying")
		await $Mage_Dying.animation_finished
		emit_signal("_on_enemy_death", experience)
		queue_free()
	if not has_dropped_coin:
		var coin = dropped_coin.instantiate()
		get_parent().add_child(coin)
		coin.position = position
		has_dropped_coin = true
	
	await $AnimatedSprite2D.animation_finished 
	emit_signal("_on_enemy_death", experience)
	var rnd = randf()
	if rnd <= health_drop_chance:
		get_tree().get_first_node_in_group("level").spawn_item(health_item, position)
	queue_free()



func enemy():
	pass

# if the enemy takes damage
func take_damage(damage: int) -> void:
	$AnimatedSprite2D.play("damaged")
	health -= damage

# if the player has entered the body
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and health > 0:
		is_in_hitbox = true
		is_attacking = true
		player_body = body
		body.take_damage(damage)
		$AnimatedSprite2D.play("attacking")
		is_attacking = false
		$Hit_Timer.start() 

# cooldown for hitting of the enemy
func _on_hit_timer_timeout() -> void:
	if health > 0 && is_in_hitbox:
		is_attacking = true
		player_body.take_damage(damage)
		$AnimatedSprite2D.play("attacking")
		is_attacking = false
		$Hit_Timer.start(0.5)

# if body left
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_hitbox = false
		is_attacking = false
		$Hit_Timer.stop()
