extends CanvasLayer

onready var pivot = $pivot 
var mute = false setget set_mute
signal mute(val)

export var hide_on_menu = true

func _ready():
	get_tree().connect("tree_changed", self, "_on_tree_changed")

func _on_tree_changed():
	if hide_on_menu and is_inside_tree():
		var tree = get_tree()
		if is_instance_valid(tree):
			var current_scene = tree.current_scene
			if is_instance_valid(current_scene):
				var currently_in_a_level = current_scene.is_in_group("level")
				pivot.visible = currently_in_a_level


func set_mute(val):
	mute = val
	AudioServer.set_bus_mute(0, val)
	emit_signal("mute", val)
	
func _on_speaker_pressed():
	set_mute(!mute)


var mute_music = false setget set_mute_music
signal mute_music(val)

func set_mute_music(val):
	mute_music = val
	var bus = AudioServer.get_bus_index("music")
	AudioServer.set_bus_mute(bus, val)
	emit_signal("mute_music", val)


func _on_music_pressed():
	set_mute_music(!mute_music)
