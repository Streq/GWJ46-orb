extends Node
tool

export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND

onready var sprite = $Sprite

func _process(delta):
	if Engine.editor_hint:
		sprite.modulate = Colors.get_color(palette)
func _ready():
	if !Engine.editor_hint:
		sprite.modulate = Colors.get_color(palette)

