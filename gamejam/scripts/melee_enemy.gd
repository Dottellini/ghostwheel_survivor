extends CharacterBody2D

@onready var target = get_parent().get_node("player")

@export var SPEED = 150.0
@export var health = 100

func _physics_process(delta: float) -> void:
	if target:
		velocity = global_position.direction_to(target.global_position)
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		move_and_collide(velocity * SPEED * delta)

func enemy():
	pass


func _on_hit_timer_timeout() -> void:
	pass # Replace with function body.
