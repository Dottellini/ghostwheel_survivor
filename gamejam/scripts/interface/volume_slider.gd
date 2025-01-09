extends Node

signal _volume_change

func set_value(value: float) -> void:
	self.value = value

func _on_value_changed(value: float) -> void:
	emit_signal("_volume_change", value)
