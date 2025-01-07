extends Label

var time_elapsed = 0.0
var timer_stopped = false

func reset() -> void:
	time_elapsed = 0.0
	timer_stopped = false	
	
func stop() -> void:
	timer_stopped = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !timer_stopped:
		time_elapsed += delta
		$".".text = "%02d:%02d:%02d" % [time_elapsed / 60 / 60, fmod(time_elapsed / 60,  60), fmod(time_elapsed, 60)]
