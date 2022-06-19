extends Node


onready var levels = get_children()
var current_level = -1 setget set_current_level
var highest_available = 0


export var level_menu : PackedScene

func _ready():
	_load()

func next_level():
	self.current_level += 1
	if current_level>=levels.size():
		Music.play_ambience("clap")
		get_tree().change_scene_to(level_menu)
		
	else:
		reload_current_level()
	
func prev_level():
	self.current_level -= 1
	reload_current_level()

func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			next_level()
		if event.is_action_pressed("prev_level"):
			prev_level()

func goto_level(index):
	self.current_level = index
	reload_current_level()

func reload_current_level():
	get_tree().change_scene_to(levels[current_level].scene)

const SAVE_PATH = "user://pulf.save"


func set_current_level(val):
	current_level = val
	if current_level > highest_available:
		highest_available = current_level
		_save()
		

func _save():
	var save = File.new()
	save.open(SAVE_PATH, File.WRITE)
	save.store_var({highest_available=highest_available})
	save.close()
func _load():
	var save = File.new()
	if save.open(SAVE_PATH, File.READ) == OK:
		var highscore = save.get_var()
		highest_available = highscore.highest_available
