extends Node
tool

export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND setget set_palette

onready var sprite = $Sprite

var ready = false
func _ready():
	ready = true
	if !Engine.editor_hint:
		sprite.modulate = Colors.get_color(palette)
func _process(delta):
	if Engine.editor_hint and is_instance_valid(sprite):
		sprite.modulate = Colors.get_color(palette)
	


func set_palette(val):
	palette = val
	if ready:
		sprite.modulate = Colors.get_color(palette)
