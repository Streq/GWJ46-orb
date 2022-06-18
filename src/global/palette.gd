tool
extends Node
class_name Colors

enum NAMES {
	BACKGROUND,
	TEXT,
	GRASS_FLOOR,
	GRASS_WALL,
	WATER,
	LAVA,
	BLUE_FLOOR,
	BLUE_WALL,
	PURPLE_FLOOR,
	PURPLE_WALL
}
export var map := {
	BACKGROUND = Color("302837"),
	TEXT = Color("F9CEC2"),
	GRASS_FLOOR = Color("006552"),
	GRASS_WALL = Color("025241"),
	WATER = Color("77c8d4"),
	LAVA = Color("a14e4a"),
	BLUE_FLOOR = Color("025860"),
	BLUE_WALL = Color("02464d"),
	PURPLE_FLOOR = Color("4c2e4f"),
	PURPLE_WALL = Color("402742"),
}

static func get_color(index:int):
	var key = NAMES.keys()[index]
	return COLORS.map[key]
