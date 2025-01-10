extends Node

var pause_requests: Dictionary = {}

# Fordert eine Pause an
func request_pause(source: String) -> void:
	pause_requests[source] = true
	_update_pause_state()

# Hebt eine Pauseanforderung auf
func release_pause(source: String) -> void:
	pause_requests.erase(source)
	_update_pause_state()
	
func clear_requests() -> void:
	pause_requests.clear()
	_update_pause_state()

# Aktualisiert den Pausenzustand
func _update_pause_state() -> void:
	get_tree().paused = pause_requests.size() > 0
