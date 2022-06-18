extends CanvasLayer

export var level_select : PackedScene


func _on_new_game():
	Levels.goto_level(0)
	
func _on_choose_level():
	get_tree().change_scene_to(level_select)
