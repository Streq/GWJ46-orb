extends Polygon2D

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

func _ready():
	var par = get_parent()
	yield(par, "ready")
	col = CollisionPolygon2D.new()
	par.add_child(col)
	col.polygon = polygon
	col.transform = transform
