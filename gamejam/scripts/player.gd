extends CharacterBody2D
var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
const SPEED = 200.0
@export var SCORE: int = 10
@export var HEALTH = 1000.0

signal _on_death

var projectile_scene: PackedScene 

func _physics_process(delta: float) -> void:
	if HEALTH<=0:
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
	_on_death.emit()
	
	
func take_damage(damage: int) -> void:
	HEALTH -= damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_scene = preload("res://scenes/projectile_one.tscn")
	$Game_over.visible = false
	shoot_projectile()
	#var instance = projectile_scene.instantiate()
	#instance.get_node("Timer").start()
	#projectile_scene.pre_timer()
	$Timer.start()

func shoot_projectile() -> void:
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		if projectile:
			projectile.global_position = self.global_position  # Assuming this script is on a Node2D
			projectile.set_direction(dir)  # Ensure 'velocity' is defined
			get_tree().current_scene.add_child(projectile)
			#move_and_slide()
		else:
			print("Failed to instantiate projectile.")
	else:
		print("Projectile scene is not assigned.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthText.text = str("Health: ", HEALTH)
	pass

func player():
	pass


func _on_timer_timeout() -> void:
	shoot_projectile()
	$Timer.start()
