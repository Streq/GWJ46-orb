extends Button

export var scene:PackedScene

func trigger():
	get_tree().change_scene_to(scene)
