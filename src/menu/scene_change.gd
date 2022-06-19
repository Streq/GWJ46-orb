extends Node

export var scene : PackedScene
export (String, FILE, "*.tscn,*.scn") var scene_path : String


func trigger():
	if scene:
		get_tree().change_scene_to(scene)
	else:
		get_tree().change_scene(scene_path)
