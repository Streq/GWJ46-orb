extends Node2D
tool

export (String, "GRASS", "BLUE", "PURPLE") var theme := "GRASS" setget set_theme

var ready = false

func _ready():
	ready = true
	set_theme(theme)
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func set_theme(val):
	theme = val
	if !ready:
		return
#		yield(get_tree().root, "ready")
#		ready = true
	for wall in Group.get_all("wall_color"):
		wall.palette = COLORS.NAMES[theme + "_WALL"]
	for flr in Group.get_all("floor_color"):
		flr.palette = COLORS.NAMES[theme + "_FLOOR"]
