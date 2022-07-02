tool
extends Polygon2D

export (Colors.NAMES) var palette := Colors.NAMES.BACKGROUND setget set_palette

var col : CollisionPolygon2D = null

var active := true setget set_active


func set_active(val):
	active = val
	visible = active
	col.disabled = !active

func disappear():
	set_active(false)

func appear():
	set_active(true)

func _process(delta):
	if Engine.editor_hint:
		color = Colors.get_color(palette)
func _ready():
	if !Engine.editor_hint:
		color = Colors.get_color(palette)
		var par = get_parent()
		yield(par, "ready")
		col = CollisionPolygon2D.new()
		par.add_child(col)
		col.polygon = polygon
		col.transform = transform

func set_palette(val):
	palette = val
	color = Colors.get_color(palette)
