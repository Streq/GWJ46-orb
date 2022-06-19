extends Node
class_name AudioCrossfadePlayer

export var bus: String = "Master"

# References to the nodes in our scene
onready var _anim_player := $AnimationPlayer
onready var _track_1 := $Track1
onready var _track_2 := $Track2

var track = 0
func _ready():
	_track_1.bus = bus
	_track_2.bus = bus

# crossfades to a new audio stream
func crossfade_to(audio_stream: AudioStream) -> void:


	# The `playing` property of the stream players tells us which track is active. 
	# If it's track two, we fade to track one, and vice-versa.
	if track:
		if !audio_stream:
			_anim_player.play("FadeOutOfTrack2")
		else:
			if _track_1.stream != audio_stream:
				_track_1.stream = audio_stream
			if !_track_1.playing:
				_track_1.play()
			_anim_player.play("FadeToTrack1")
		track = 0
	else:
		if !audio_stream:
			_anim_player.play("FadeOutOfTrack1")
		else:
			if _track_2.stream != audio_stream:
				_track_2.stream = audio_stream
			if !_track_2.playing:
				_track_2.play()
			_anim_player.play("FadeToTrack2")
		track = 1


func pause():
	_track_1.stream_paused = true
	_track_2.stream_paused = true
	
func unpause():
	_track_1.stream_paused = false
	_track_2.stream_paused = false
