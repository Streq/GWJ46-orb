extends Label

func _ready():
	Levels.connect("level_changed",self,"_level_changed")
	
func _level_changed(level):
	text = str(level+1)
