extends Panel
signal hit

var wheel
var pointer
var button
var is_pressed
var rotation_speed
var deceleration
var rotation_angle

var current_hit_area
var spin_over = false
var stopped = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	is_pressed = false
	rotation_speed = randf_range(720.0, 1440.0) # random spin speed for the wheel at the start
	deceleration = 200 # how fast the wheel stops moving
	rotation_angle = 0.0 # idfk
	button = $Button
	wheel = $wheel
	pointer = $pointer/pointer_body
	button.disabled = true
	pointer.set_monitoring(false)
	# wheel.rotation = deg_to_rad(randf_range(0, 360)) # Zufällige Startposition
	button.pressed.connect(self._button_pressed) # connects the button press signal to a function
	hit.connect(get_tree().get_first_node_in_group("player")._on_gambling_hit) # gets the player from the scene

func _on_pointer_body_area_entered(area: Area2D) -> void:
	# Speichert die getroffene Area
	current_hit_area = area

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_pressed:
		rotation_speed = max(0.0, rotation_speed - deceleration * delta) # decelerates the spin speed, until 0
		if rotation_speed == 0.0 and !stopped: 
			stopped = true
			spin_over = true
		if rotation_speed == 0.0 and spin_over: # if 0, emits a signal to the player with the index of the area it landed on
			match current_hit_area.name:
				"first area":
					emit_signal("hit", 1)
				"second area":
					emit_signal("hit", 2)
				"third area":
					emit_signal("hit", 3)
				"forth area":
					emit_signal("hit", 4)
				"fifth area":
					emit_signal("hit", 5)
				"sixth area":
					emit_signal("hit", 6)
				"seventh area":
					emit_signal("hit", 7)
				"eighth area":
					emit_signal("hit", 8)
			_reset_to_default() # resets the wheel so it can be spun again later
			
		else:
			rotation_angle += rotation_speed * delta # increments the angle the wheel is at by the remaining speed
			wheel.rotation = deg_to_rad(rotation_angle) # sets rotation

func _button_pressed():
	stopped = false
	is_pressed = true
	current_hit_area = null # Zurücksetzen der Treffer-Area
	pointer.set_monitoring(true)
	PhysicsServer2D.set_active(true)
	wheel.rotation = deg_to_rad(randf_range(0, 360)) # randomizes the starting rotation of the wheel
	
func _reset_to_default():
	is_pressed = false
	stopped = true
	spin_over = false
	rotation_speed = randf_range(720.0, 1440.0)
	deceleration = 200
	rotation_angle = 0.0
	button.disabled = true
	pointer.set_monitoring(false)
