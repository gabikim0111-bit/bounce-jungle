extends AudioStreamPlayer

# Background music for the tower. The two tracks alternate per level:
# 1 snow -> A, 2 water -> B, 3 desert -> A, 4 nature -> B.
@export var track_a: AudioStream
@export var track_b: AudioStream
# Pitch used in the water section so the music sounds submerged.
@export var UNDERWATER_PITCH = 0.85

# Level boundaries in world y. Up is negative.
const WATER_BOTTOM = -448.0
const DESERT_BOTTOM = -1664.0
const NATURE_BOTTOM = -2880.0

var player
var current_level = 0


func _ready():
	player = get_parent().get_node_or_null("CharacterBody2D")
	for s in [track_a, track_b]:
		if s is AudioStreamMP3:
			s.loop = true


func level_at(y):
	if y <= NATURE_BOTTOM:
		return 4
	if y <= DESERT_BOTTOM:
		return 3
	if y <= WATER_BOTTOM:
		return 2
	return 1


func _process(_delta):
	if player == null:
		return
	var level = level_at(player.global_position.y)
	if level == current_level:
		return
	current_level = level
	pitch_scale = UNDERWATER_PITCH if level == 2 else 1.0
	# odd levels take track A, even levels track B
	var wanted = track_a if level % 2 == 1 else track_b
	if stream != wanted or not playing:
		stream = wanted
		play()
