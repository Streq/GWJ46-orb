extends CanvasItem
tool

export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND

func _process(delta):
	if Engine.editor_hint:
		modulate = Colors.get_color(palette)
func _ready():
	if !Engine.editor_hint:
		modulate = Colors.get_color(palette)

