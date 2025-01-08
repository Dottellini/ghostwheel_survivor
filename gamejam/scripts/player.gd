extends CharacterBody2D
var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
var SPEED = 200.0
const gambling = preload("res://scenes/gambling/wheel_of_fortune.tscn")
@export var SCORE: int = 0 # This is the score and the exp of the player
@export var COINS = 0
@export var MAX_HEALTH: int = 1000
var HEALTH: int = 1000
var initial_health = 0

var damage_buff = 0
var defence: float = 0

var is_speed_buff = false
var is_defence_buff = false
var is_damage_buff = false

var last_skin_index = 0

var projectile_scene: PackedScene 
var is_flickering = false

signal _on_death

func _physics_process(delta: float) -> void:
	if HEALTH <= 0:
		HEALTH = 0
		player_death()
		
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if Input.get_axis("ui_left", "ui_right") != 0  or Input.get_axis("ui_up", "ui_down") !=0:
		dir=Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if is_flickering:
		$AnimatedSprite2D.set_visible(randi_range(0,1))
	else:
		$AnimatedSprite2D.set_visible(true)
	
	move_and_slide()
	

func player_death() -> void:
	get_tree().paused = true # freezes game
	emit_signal("_on_death")


func take_damage(damage: int) -> void:
	is_flickering = true
	
	if defence > 0:
		HEALTH -= (damage * (defence*100)) / 100
	elif defence < 0:
		HEALTH += -damage + ((damage * (defence*100)) / 100)
	else:
		HEALTH -= damage
	
	await get_tree().create_timer(0.2).timeout
	is_flickering = false


func add_health_percentage(health_percentage: float) -> void:
	if health_percentage < 0 or health_percentage > 1:
		print("Health_percentage must be between 0 and 1")
		return
	add_health_fix(MAX_HEALTH * health_percentage)
	
func add_health_fix(added_health: int) -> void:
	var health_to_be = HEALTH + added_health
	HEALTH = MAX_HEALTH if health_to_be >= MAX_HEALTH else health_to_be
	
func add_score(added_score: int) -> void:
	SCORE += added_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Game_over.visible = false
	shoot_projectile()
	$Timer.start()

func shoot_projectile() -> void:
	for i in Globaly.scene_list:
		var projectile = i.instantiate()
		if projectile:
			projectile.global_position = self.global_position  # Assuming this script is on a Node2D
			projectile.set_direction(dir)  # Ensure 'velocity' is defined
			get_tree().current_scene.add_child.call_deferred(projectile)
			#move_and_slide()
		else:
			print("Failed to instantiate projectile.")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthText.text = str("Health: ", HEALTH)
	pass


func _on_timer_timeout() -> void:
	shoot_projectile()
	$Timer.start()

func _on_gambling_pickup(): # shows the wheel of fortune and pauses the game
	$wheel_of_fortune.visible = true
	get_tree().paused = true

func _on_gambling_hit(index: int):
	print(index)
	await get_tree().create_timer(3.0).timeout
	# logic for giving the player new skins and buffs in the cases below
	match index:
		1:
			#TODO: Großer Reifen SKIN
			$AnimatedSprite2D.play("skin_big")
			skin_ability(index)
		2:
			is_defence_buff = true
			defence += 0.5
			$Buff_Timer.start()
		3:
			#TODO: Brennender Reifen SKIN
			$AnimatedSprite2D.play("skin_burning")
			skin_ability(index)
		4:
			# Damage Buff
			is_damage_buff = true
			damage_buff += 100
			$Buff_Timer.start()
		5:
			#TODO: Skin Fast Wheel
			$AnimatedSprite2D.play("skin_fast")
			skin_ability(index)
		6:
			# Healing Buff
			add_health_percentage(0.5)
		7:
			#TODO: Metal Skin
			$AnimatedSprite2D.play("skin_metal")
			skin_ability(index)
		8:
			# Speed Buff
			SPEED += 500
			is_speed_buff = true
			$Buff_Timer.start()
			
	$wheel_of_fortune.visible = false
	get_tree().paused = false

# Change Ability of the player based on the skin
func skin_ability(skin_number: int):
	# Remove the last skin ability
	if last_skin_index > 0 and last_skin_index != skin_number:
		match last_skin_index:
			1:
				# less max health
				MAX_HEALTH = initial_health
				if HEALTH > MAX_HEALTH:
					HEALTH = MAX_HEALTH
			3:
				# less damage
				if damage_buff > 50:
					damage_buff -= 50
				else:
					damage_buff = 0
			5:
				# more speed, less defence
				SPEED += 100
				defence -= 0.3
			7:
				# less speed, more defence
				SPEED -= 200
				defence += 0.3
	# Add skin ability
	if last_skin_index != skin_number:
		match skin_number:
			1:
				# more max health
				initial_health = MAX_HEALTH
				MAX_HEALTH += 500
				HEALTH = MAX_HEALTH
				last_skin_index = skin_number
			3:
				# more damage
				damage_buff += 50
			5:
				# more defence, less speed
				SPEED -= 100
				defence += 0.3
			7:
				#mehr speed, weniger defence
				SPEED += 200
				defence -= 0.3

func _on_buff_timer_timeout() -> void:
	$Buff_Timer.stop()
	if is_defence_buff:
		is_defence_buff = false
		defence = 0
	elif is_damage_buff:
		is_damage_buff = false
		damage_buff = 0
	elif is_speed_buff:
		is_speed_buff = false
		SPEED -= 500

func _on_coin_pickup(amount: int):
	print("worth in player", amount)
	COINS += amount
