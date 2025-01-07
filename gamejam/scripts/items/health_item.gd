extends Node

@export var health_amount = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Beispiel: prüfe, ob das Projektil einen Feind trifft.
		body.add_health(health_amount)  # Rufe eine Funktion im Feindobjekt auf.
		queue_free()  # Entferne das Projektil.
