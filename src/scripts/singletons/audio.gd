extends Node

const AUDIO_PLAYER_COUNT := 32
var audio_players := []
var next_player_index := 0


func _ready():
	for i in AUDIO_PLAYER_COUNT:
		var player = AudioStreamPlayer.new()
		audio_players.append(player)
		self.add_child(player)


## path: String | Array[String]
func play_at(path: Variant):
	if path is Array:
		path = path.pick_random()
	if not path is String:
		push_error("wrong type for `path`: ", type_string(typeof(path)))
	
	var sound = load("res://assets/sounds/" + path)
	play(sound)


func play(sound: Resource, volume_modifier := 0):
	var player = audio_players[next_player_index]
	player.stream = sound
	player.volume_db = -25 + volume_modifier
	player.pitch_scale = randf_range(0.9, 1.1)
	player.play()
	next_player_index = wrapi(next_player_index + 1, 0, AUDIO_PLAYER_COUNT)
