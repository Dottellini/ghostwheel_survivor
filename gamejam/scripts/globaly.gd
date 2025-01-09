extends Node
# [0] = shuriken; [1] = ice bomb; [2] = ring of fire
static var scene_list: Array = [null, null, null, null, null, null, null, null]
static var cooldowns: Array [float] = [2.0, 3.0, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0]
static var current_cooldowns: Array [float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
static var weapons_acquired: Array [bool] = [false, false, false, false, false, false, false, false]
static var array_size: int = scene_list.size()
var buff: int
var player: CharacterBody2D
var got_player: bool

static var shuriken = preload("res://scenes/weapons/shuriken/shuriken.tscn")
static var ice_bomb = preload("res://scenes/weapons/ice_shot/ice_shot.tscn")
static var ring_of_fire = preload("res://scenes/weapons/fireball/fireball.tscn")

var volume_in_db: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not got_player:
		_try_get_player()
	else:
		for i in 8:
			if weapons_acquired[i]:
				current_cooldowns[i] += delta
				if current_cooldowns[i] >= cooldowns[i]:
					var projectile = scene_list[i].instantiate()
					match i:
						0, 1:
							projectile.global_position.x = player.global_position.x  # Assuming this script is on a Node2D
							projectile.global_position.y = player.global_position.y  # Assuming this script is on a Node2D
							projectile.set_direction(player.dir)  # Ensure 'velocity' is defined
							player.owner.add_child.call_deferred(projectile)
						2:
							player.add_child(projectile)
					current_cooldowns[i] = 0.0

func _try_get_player() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		got_player = true

static func acquire_shuriken() -> void:
	scene_list[0] = shuriken
	weapons_acquired[0] = true
	print("i am in acquire shuriken, scene_list:", scene_list)

static func acquire_ice_bomb() -> void:
	scene_list[1] = ice_bomb
	weapons_acquired[1] = true

static func acquire_ring_of_fire() -> void:
	scene_list[2] = ring_of_fire
	weapons_acquired[2] = true
