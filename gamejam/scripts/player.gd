extends CharacterBody2D
var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
const SPEED = 200.0
const gambling = preload("res://scenes/gambling/wheel_of_fortune.tscn")
@export var SCORE: int = 0 # This is the score and the exp of the player
@export var HEALTH = 1000.0

var projectile_scene: PackedScene 

signal _on_death

func _physics_process(delta: float) -> void:
	if HEALTH <= 0:
		HEALTH = 0.0
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
	
	move_and_slide()
	

func player_death() -> void:
	get_tree().paused = true # freezes game
	emit_signal("_on_death")


func take_damage(damage: int) -> void:
	HEALTH -= damage
	
func add_health(added_health: int) -> void:
	HEALTH += added_health
	
func add_score(added_score: int) -> void:
	SCORE += added_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_scene = load("res://scenes/weapons/shuriken/shuriken.tscn")
	#Globaly.scene_list.append(projectile_scene)
	Globaly.scene_list.append(preload("res://scenes/weapons/ice_shot/ice_shot.tscn"))
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

func player():
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
	#TODO insert logic for giving the player new skins in the cases below
	match index:
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
		6:
			pass
		7:
			pass
		8:
			pass
	$wheel_of_fortune.visible = false
	get_tree().paused = false
