extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
