extends CharacterBody2D
@export var dir = Vector2(Input.get_axis("ui_Left", "ui_Right"), Input.get_axis("ui_Up", "ui_Down"))
var SPEED = 200.0
const gambling = preload("res://scenes/gambling/wheel_of_fortune.tscn")
@export var SCORE: int = 0 # This is the score and the exp of the player
@export var COINS = 0
@export var MAX_HEALTH: int = 1000
var HEALTH: int = 1000
var initial_health = 0

var damage_buff: int = 0
var defence: float = 0

var is_speed_buff = false
var is_defence_buff = false
var is_damage_buff = false

var last_skin_index = 0

var projectile_scene: PackedScene 
var is_flickering = false

var animator: AnimatedSprite2D
var current_skin: String = "default"
var big: bool
var pause_manager = PauseManager

signal _on_death

func _physics_process(delta: float) -> void:
	Globaly.buff=damage_buff
	if HEALTH <= 0:
		HEALTH = 0
		player_death()
		
	dir = Vector2(Input.get_axis("ui_Left", "ui_Right"), Input.get_axis("ui_Up", "ui_Down"))
	
	if dir.x:
		velocity.x = dir.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if dir.y:
		velocity.y = dir.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if is_flickering:
		animator.set_visible(randi_range(0,1))
	else:
		animator.set_visible(true)
	
	_handle_animations(dir.x, dir.y)
	move_and_slide()
	

func player_death() -> void:
	pause_manager.request_pause("player")
	emit_signal("_on_death")


func take_damage(damage: int) -> void:
	is_flickering = true
	$HitSoundPlayer.play()
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
	$Timer.start()
	animator = $AnimatedSprite2D
	animator.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthBar.max_value = MAX_HEALTH
	$HealthBar.value = HEALTH

func _on_gambling_pickup(): # shows the wheel of fortune and pauses the game
	$wheel_of_fortune.visible = true
	$wheel_of_fortune/Panel/Button.disabled = false
	pause_manager.request_pause("player")

func _on_gambling_hit(index: int):
	print(index)
	await get_tree().create_timer(3.0).timeout
	# logic for giving the player new skins and buffs in the cases below
	match index:
		1:
			#TODO: Großer Reifen SKIN
			current_skin = "default"
			big = true
			skin_ability(index)
		2:
			is_defence_buff = true
			defence += 0.5
			$Buff_Timer.start()
		3:
			#TODO: Brennender Reifen SKIN
			current_skin = "skin_burning"
			big = false
			skin_ability(index)
		4:
			# Damage Buff
			is_damage_buff = true
			damage_buff += 100
			$Buff_Timer.start()
		5:
			#TODO: Skin Fast Wheel
			current_skin = "skin_fast"
			big = false
			skin_ability(index)
		6:
			# Healing Buff
			add_health_percentage(0.5)
		7:
			#TODO: Metal Skin
			current_skin = "skin_metal"
			big = false
			skin_ability(index)
		8:
			# Speed Buff
			SPEED += 500
			is_speed_buff = true
			$Buff_Timer.start()
			
	$wheel_of_fortune.visible = false
	pause_manager.release_pause("player")

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
	COINS += amount

func _handle_animations(x: float, y: float) -> void:
	var factor: float = 1.0
	if big:
		factor = 1.5
		animator.speed_scale = 0.6
	else:
		animator.speed_scale = 1
	if y == 0 and x != 0: # if going horizontally
		animator.scale.x = 2 * factor
		animator.scale.y = 2 * factor
		if x < 0: # if going left
			animator.flip_h = false
			animator.play(current_skin + "_go_horizontal")
		if x > 0: # if going right
			animator.flip_h = true
			animator.play(current_skin + "_go_horizontal")
	elif x == 0 and y != 0: # if going vertically
		animator.scale.x = 2.3 * factor
		animator.scale.y = 2.3 * factor
		if y < 0: # if going up
			animator.play(current_skin + "_go_vertical_away")
		if y > 0: # if going down
			animator.play(current_skin + "_go_vertical_towards")
	elif x == 0 and y == 0: # if not moving
		animator.scale.x = 2 * factor
		animator.scale.y = 2 * factor
		animator.play(current_skin + "_idle")
	else: # if going diagonally
		animator.scale.x = 2.3 * factor
		animator.scale.y = 2.3 * factor
		if y < 0: # going north
			if x > 0: # if going north-east
				animator.flip_h = true
				animator.play(current_skin + "_go_diagonal_away")
			else: # if going north-west
				animator.flip_h = false
				animator.play(current_skin + "_go_diagonal_away")
		if y > 0: # going south
			if x > 0: # going south-east
				animator.flip_h = false
				animator.play(current_skin + "_go_diagonal_towards")
			else:
				animator.flip_h = true
				animator.play(current_skin + "_go_diagonal_towards")
