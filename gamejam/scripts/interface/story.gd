extends Node

var current_label = 0
var labels
var continue_label
var disclaimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disclaimer = $Disclaimer
	labels = {
		0: $Label,
		1: $Label2,
		2: $Label3,
		3: $Label4,
		4: $Label5,
		5: $ContinueLabel
	}
	
	continue_label = $ContinueLabel
	
	for label in labels.values():
		label.hide()

	labels[0].show()

func _input(event: InputEvent) -> void:
	if event.is_action("Enter"):
		get_tree().change_scene_to_file("res://scenes/Interface/main_menu.tscn")

# Show next story label
func next_label() -> void:
	current_label += 1
	labels[current_label].show()
	
	if current_label >= 4:
		$SkipLabel.hide()
		labels[5].show()
		$BlinkingTimer.start()
		$Timer.stop()
		
	
# Show every story label for the timers set time
func _on_timer_timeout() -> void:
	next_label()
	

# Start story after disclaimer was shown
func _on_disclaimer_timer_timeout() -> void:
	disclaimer.queue_free()
	$Timer.start()

# Blinks the continuelabel
func _on_blinking_timer_timeout() -> void:
	continue_label.visible = !continue_label.visible
