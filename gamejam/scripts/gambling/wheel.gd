extends Panel
signal hit

var wheel
var pointer
var is_pressed
var rotation_speed
var deceleration
var rotation_angle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_pressed = false
	rotation_speed = randf_range(720.0, 1440.0) # random spin speed for the wheel at the start
	deceleration = 200 # how fast the wheel stops moving
	rotation_angle = 0.0 # idfk
	var button = $Button
	wheel = $wheel
	pointer = $pointer/pointer_body
	button.pressed.connect(self._button_pressed) # connects the button press signal to a function
	hit.connect(get_tree().get_first_node_in_group("player")._on_gambling_hit) # gets the player from the scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_pressed:
		rotation_speed = max(0.0, rotation_speed - deceleration * delta) # decelerates the spin speed, until 0
		if rotation_speed == 0.0: # if 0, emits a signal to the player with the index of the area it landed on
			match pointer.get_overlapping_areas()[0].name:
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
	is_pressed = true
	wheel.rotation = deg_to_rad(randf_range(0, 360)) # randomizes the starting rotation of the wheel
	
func _reset_to_default():
	is_pressed = false
	rotation_speed = randf_range(720.0, 1440.0)
	deceleration = 200
	rotation_angle = 0.0
