extends Node
tool
export var prop:="modulate"
export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND

func _ready():
	if !Engine.editor_hint:
		var parent = get_parent()
		yield(parent,"ready")
		parent.set(prop, Colors.get_color(palette))

func _process(delta):
	if Engine.editor_hint:
		get_parent().set(prop, Colors.get_color(palette))
