extends Node
tool

export var radius := 10.0 setget set_radius
export var sides := 32 setget set_sides

var can_reprocess = false
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_parent(), "ready")
	can_reprocess = true
	reprocess()
func set_sides(val):
	sides = val
	reprocess()

func set_radius(val):
	radius = val
	reprocess()

func reprocess():
	if can_reprocess:
		var parent = get_parent()
		var arr = []
		for side in sides:
			arr.push_back(Vector2(0,radius).rotated(TAU*side/sides))
		parent.polygon = PoolVector2Array(arr)
