extends Button

onready var hover = $hover
func _ready():
	if !disabled:
		connect("mouse_entered", hover, "play")
