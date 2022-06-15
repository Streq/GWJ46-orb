extends CanvasLayer

onready var container = $GridContainer
export var LEVEL_BUTTON : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var levels = Levels.get_children()
	for index in Levels.get_child_count():
		var level = levels[index]
		var button : Button = LEVEL_BUTTON.instance()
		var scene = level.scene
		button.text = str(index+1)
		button.connect("pressed", self, "_goto_level", [index])
		container.add_child(button)
		
func _goto_level(index):
	Levels.goto_level(index)
