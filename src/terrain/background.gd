extends CanvasLayer
tool
export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND

onready var rect = $ColorRect

func _process(delta):
	if Engine.editor_hint:
		rect.color = Colors.get_color(palette)
func _ready():
	if !Engine.editor_hint:
		rect.color = Colors.get_color(palette)
