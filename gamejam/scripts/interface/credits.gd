extends CanvasLayer

const SONG = preload("res://assets/credits/Ghostwheel survivor.mp3")

var audio_player: AudioStreamPlayer
var credits_text: CenterContainer
var lyrics: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player = $AudioStreamPlayer
	credits_text = $CenterContainer2
	lyrics = $CenterContainer/lyrics
	_show_lyrics()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	credits_text.global_position.y -= 0.025


func _on_audio_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/Interface/main_menu.tscn")
	
func _show_lyrics() -> void:
	lyrics.text = "♪ ♪"
	await get_tree().create_timer(1).timeout # 00:01
	lyrics.text = "♪ YEAAAAAAH! ♪"
	await get_tree().create_timer(5).timeout # 00:06
	lyrics.text = "♪ ♪♫♪♫♪♫ ♪"
	await get_tree().create_timer(10.75).timeout # 00:16.75
	lyrics.text = "♪ Ich bin Ghostriders Rad! ♪"
	await get_tree().create_timer(3.5).timeout # 00:20.25
	lyrics.text = "♪ Bestreite mit ihm den Pfad ♪"
	await get_tree().create_timer(3.5).timeout # 00:23.75
	lyrics.text = "♪ Doch dann ist er besoffen gefahren ♪"
	await get_tree().create_timer(3.5).timeout # 00:27.25
	lyrics.text = "♪ Das könnte er sich sparen ♪"
	await get_tree().create_timer(2.5).timeout # 00:29.75
	lyrics.text = "Fahren unter dem Einfluss von Alkohol ist nicht cool!"
	await get_tree().create_timer(3.25).timeout # 00:33
	lyrics.text = "♪ Ich- ♪"
	await get_tree().create_timer(0.75).timeout # 00:33.75
	lyrics.text = "♪ Bin- ♪"
	await get_tree().create_timer(0.75).timeout # 00:34.5
	lyrics.text = "♪ Von Ghostriders Bike abgefallen! ♪"
	await get_tree().create_timer(3.25).timeout # 00:37.75
	lyrics.text = "♪ (YEAH!) ♪"
	await get_tree().create_timer(1.75).timeout # 00:39.5
	lyrics.text = "♪ Bro ist voll der scheiß Fahrer, ♪"
	await get_tree().create_timer(1.5).timeout # 00:41
	lyrics.text = "♪ Musste in 'nen fucking Baum knallen! ♪"
	await get_tree().create_timer(3.25).timeout # 00:44.25
	lyrics.text = "♪ (BAM!) ♪"
	await get_tree().create_timer(1.75).timeout # 00:46
	lyrics.text = "♪ Jetzt Will mich ne Horde Monster krallen! ♪"
	await get_tree().create_timer(4.5).timeout # 00:50.5
	lyrics.text = "♪ Doch- ♪"
	await get_tree().create_timer(1).timeout # 00:51.5
	lyrics.text = "♪ Werd' sie alle abknallen! ♪"
	await get_tree().create_timer(2.25).timeout # 00:53.75
	lyrics.text = "♪ YEAH! ♪"
	await get_tree().create_timer(2).timeout # 00:55.75
	lyrics.text = "♪ ♪♫♪♫♪♫ ♪"
	await get_tree().create_timer(6).timeout # 01:01.75
	lyrics.text = "♪ Aber mal im ernst! ♪"
	await get_tree().create_timer(3).timeout # 01:04.75
	lyrics.text = "♪ Wer fährt besoffen ein flammendes Motorrad? ♪"
	await get_tree().create_timer(4.25).timeout # 01:09
	lyrics.text = "♪ Was eine beschissene Idee ♪"
	await get_tree().create_timer(3.5).timeout # 01:12.5
	lyrics.text = "♪ Zu Alkohol sage ich: Nee! ♪"
	await get_tree().create_timer(3).timeout # 01:15.5
	lyrics.text = "♪ Coole Kinder sagen NEIN zu Alkohol! ♪"
	await get_tree().create_timer(3).timeout # 01:18.5
	lyrics.text = "♪ Ich- ♪"
	await get_tree().create_timer(0.75).timeout # 01:19:25
	lyrics.text = "♪ Bin- ♪"
	await get_tree().create_timer(0.75).timeout # 01:20
	lyrics.text = "♪ Von Ghostriders Bike abgefallen! ♪"
	await get_tree().create_timer(3.25).timeout # 01:23.75
	lyrics.text = "♪ (YEAH!) ♪"
	await get_tree().create_timer(1.75).timeout # 01:25.5
	lyrics.text = "♪ Bro ist voll der scheiß Fahrer, ♪"
	await get_tree().create_timer(1.5).timeout # 01:27
	lyrics.text = "♪ Musste in 'nen fucking Baum knallen! ♪"
	await get_tree().create_timer(3.25).timeout # 01:30.25
	lyrics.text = "♪ (BAM!) ♪"
	await get_tree().create_timer(1.75).timeout # 01:32
	lyrics.text = "♪ Jetzt Will mich ne Horde Monster krallen! ♪"
	await get_tree().create_timer(4.75).timeout # 01:36.75
	lyrics.text = "♪ Doch- ♪"
	await get_tree().create_timer(1).timeout # 01:37.75
	lyrics.text = "♪ Werd' sie alle abknallen! ♪"
	await get_tree().create_timer(2).timeout # 01:39.75
	lyrics.text = "♪ YEAH! ♪"
	await get_tree().create_timer(2).timeout # 01:41.75
	lyrics.text = "♪ Räume alle Monster aus dem Weg ♪"
	await get_tree().create_timer(3.25).timeout # 01:45
	lyrics.text = "♪ Fledermäuse, Magier, ihr steht mir im Weg ♪"
	await get_tree().create_timer(3).timeout # 01:48
	lyrics.text = "♪ Ich gehe meinen Weg ♪"
	await get_tree().create_timer(2.5).timeout # 01:50.5
	lyrics.text = "♪ Und gehe jetzt weg ♪"
	await get_tree().create_timer(2.25).timeout # 01:52.75
	lyrics.text = "Tschüss"
	await get_tree().create_timer(1.75).timeout # 01:54.5
	lyrics.text = "♪ ♪♫♪♫♪♫ ♪"
	await get_tree().create_timer(13.25).timeout # 01:54.5
	lyrics.text = "♪ Ich- ♪"
	await get_tree().create_timer(0.75).timeout # 01:55.25
	lyrics.text = "♪ Bin- ♪"
	await get_tree().create_timer(0.75).timeout # 01:56
	lyrics.text = "♪ Von Ghostriders Bike abgefallen! ♪"
	await get_tree().create_timer(3.25).timeout # 01:59.25
	lyrics.text = "♪ (YEAH!) ♪"
	await get_tree().create_timer(1.75).timeout # 02:01
	lyrics.text = "♪ Bro ist voll der scheiß Fahrer, ♪"
	await get_tree().create_timer(1.5).timeout # 02:02.5
	lyrics.text = "♪ Musste in 'nen fucking Baum knallen! ♪"
	await get_tree().create_timer(3.25).timeout # 02:05.75
	lyrics.text = "♪ (BAM!) ♪"
	await get_tree().create_timer(1.75).timeout # 02:07.5
	lyrics.text = "♪ Jetzt Will mich ne Horde Monster krallen! ♪"
	await get_tree().create_timer(4.75).timeout # 02:12.25
	lyrics.text = "♪ Doch- ♪"
	await get_tree().create_timer(1).timeout # 02:13.25
	lyrics.text = "♪ Werd' sie alle abknallen! ♪"
	await get_tree().create_timer(2).timeout # 02:15.25
	lyrics.text = "♪ YEAH! ♪"
	await get_tree().create_timer(1.75).timeout # 02:17
	lyrics.text = "WICHTIG!\nGhost Rider ist ein eingetragenes Markenzeichen"
	await get_tree().create_timer(2.75).timeout # 02:19.75
	lyrics.text = "WICHTIG!\nund geistiges Eigentum von Marvel Entertainment, LLC."
	await get_tree().create_timer(4.5).timeout # 02:24.25
	lyrics.text = "WICHTIG!\nAlle Rechte an der Figur, dem Namen und den"
	await get_tree().create_timer(3).timeout # 02:27.25
	lyrics.text = "WICHTIG!\ndamit verbundenen Inhalten liegen bei Marvel."
	await get_tree().create_timer(3.25).timeout # 02:30.5
	lyrics.text = "WICHTIG!\n♪ Diese Parodie ist ein nicht-kommerzielles, kreatives Werk ♪"
	await get_tree().create_timer(4.5).timeout # 02:35
	lyrics.text = "WICHTIG!\n♪ und steht in keiner Verbindung zu Marvel Entertainment, LLC. ♪"
	await get_tree().create_timer(5).timeout # 02:40
	lyrics.text = "WICHTIG!\n♪ Sie ist als satirische oder transformative ♪"
	await get_tree().create_timer(3.5).timeout # 02:43.5
	lyrics.text = "WICHTIG!\n♪ Darstellung gedacht, die im Rahmen der geltenden ♪"
	await get_tree().create_timer(3.5).timeout # 02:48
	lyrics.text = "WICHTIG!\n♪ Urheberrechtsgesetze und des Rechts auf freie Meinungsäußerung- ♪"
	await get_tree().create_timer(6.25).timeout # 02:54.25
	lyrics.text = "WICHTIG!\nerlaubt ist"
	await get_tree().create_timer(2.75).timeout # 02:57
	lyrics.text = "♪ ♪♫♪♫♪♫ ♪"
