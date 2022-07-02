extends CanvasItem
tool

export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND setget set_palette

func _process(delta):
	if Engine.editor_hint:
		modulate = Colors.get_color(palette)
func _ready():
	if !Engine.editor_hint:
		modulate = Colors.get_color(palette)

func set_palette(val):
	palette = val
	modulate = Colors.get_color(palette)
