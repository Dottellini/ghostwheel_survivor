extends CharacterBody2D
var projectile_scene = preload("res://scenes/weapons/enemy_weapons/enemy_aura.tscn")
var projectile_big=preload("res://scenes/weapons/enemy_weapons/boss_projectile.tscn")
@onready var target = get_parent().get_node("Player")

var chest = preload("res://scenes/gambling/gambling_pickup.tscn")

@export var SPEED = 150.0
@export var base_health = 2000
@export var damage = 100
var health=2000
var pr=health*10
var procent

var is_attacking = false
var is_damaged = false
var in_range = false
var player_body

func mode1():
	$Attack_Range.set_monitoring(false)
	$Hitbox.set_monitoring(true)

func mode2():
	$Attack_Range.set_monitoring(true)
	$Hitbox.set_monitoring(false)

func mode3():
	$Shoot_Cooldown.wait_time=1

func mode4():
	$Attack_Range.set_monitoring(false)
	$Hitbox.set_monitoring(true)
	$Hit_Timer.wait_time=0.3

func mode5():
	projectile_scene=projectile_big
	
func health_status():
	procent=(float(health)*100.0)/base_health
	if procent>80:
		mode1()
	elif procent<=80 and procent>60:
		mode2()
	elif procent<=60 and procent>20:
		mode5()
	elif procent<=20 and procent >10:
		mode3()
	elif procent<=10:
		mode4()

func _physics_process(delta: float) -> void:
	health_status()
	$ProgressBar.value=health
	if !is_attacking:
		$AnimatedSprite2D.play("moving")
	
	if health <= 0:
		$CollisionShape2D.set_deferred("monitoring",false)
		$AnimatedSprite2D.play("dying")
		await get_tree().create_timer(1.0).timeout 
		get_tree().get_first_node_in_group("level").spawn_item(chest, position)
		queue_free()
	
	# move to Player
	if target and !in_range:
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
	if body.is_in_group("player") and health > 0:
		is_attacking = true
		$AnimatedSprite2D.play("attacking")
		await get_tree().create_timer(1.0).timeout 
		is_attacking = false
		player_body = body
		body.take_damage(damage)
		$Hit_Timer.start() 

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
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("shooting")
		in_range  = true
		velocity = Vector2(0, 0)
		$Shoot_Cooldown.start()


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_range = false
		velocity = global_position.direction_to(target.global_position)
		$Shoot_Cooldown.stop()


func _on_shoot_cooldown_timeout() -> void:
	shoot_projectile()
	pass
