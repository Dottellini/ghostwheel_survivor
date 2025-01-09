extends Node

var volume_slider

@export var MIN_DB: float = -20
@export var MAX_DB: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_volume = db_to_slider_value(self.volume_db)
	volume_slider = get_parent().get_node("VolumeSlider")
	volume_slider.set_value(current_volume)
	volume_slider._volume_change.connect(_change_volume)


func _change_volume(value: float):
	var volume_in_db = slider_value_to_db(value)
	Globaly.volume_in_db = volume_in_db
	self.volume_db = volume_in_db
	

# Funktion zur Umrechnung von dB-Werten in eine Skala von 0-100
func db_to_slider_value(db: float) -> float:
	return clamp(((db - MIN_DB) / (MAX_DB - MIN_DB)) * 100, 0, 100)

# Funktion zur Umrechnung von 0-100-Skala in dB-Werte
func slider_value_to_db(value: float) -> float:
	return clamp((value / 100) * (MAX_DB - MIN_DB) + MIN_DB, MIN_DB, MAX_DB)
