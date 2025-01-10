extends AudioStreamPlayer

const SONG = preload("res://assets/Sound/Kämpfende Räder sind krass (battle theme).mp3")
const SONG2 = preload("res://assets/Sound/Kämpfende Räder sind krass (battel theme 2).mp3")
const SONG3 = preload("res://assets/Sound/Kämpfende Räder sind krass (battle theme 3).mp3")

var current_song = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.volume_db = Globaly.volume_in_db
	var is_muted = Globaly.is_sound_muted
	
	if is_muted:
		self.queue_free()
	
	var nr = randi_range(0,2)
	match nr:
		0:
			stream = SONG
			current_song = 0
		1:
			stream = SONG2
			current_song = 1
		2:
			stream = SONG3
			current_song = 2
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_finished() -> void:
	match current_song:
		0:
			stream = SONG2
			current_song = 1
		1:
			stream = SONG3
			current_song = 2
		2:
			stream = SONG
			current_song = 0
	await get_tree().create_timer(1.0).timeout
	play()

func _muffle_music():
	bus = &"Muffle"

func _unmuffle_music():
	bus = &"Master"
