extends CanvasLayer
tool
export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND setget set_palette

onready var rect = $ColorRect

func _process(delta):
	if is_instance_valid(rect):
		if Engine.editor_hint:
			rect.color = Colors.get_color(palette)
func _ready():
	if is_instance_valid(rect):
		if !Engine.editor_hint:
			rect.color = Colors.get_color(palette)


func set_palette(val):
	palette = val
	if is_instance_valid(rect):
		rect.color = Colors.get_color(palette)
