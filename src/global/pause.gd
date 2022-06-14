extends CanvasLayer

onready var curtain = $ColorRect

func _ready():
	pause(get_tree().paused)

func _input(event):
	if event.is_action_pressed("pause"):
		if !get_tree().current_scene.is_in_group("menu"):
			pause(!get_tree().paused)
func pause(val):
	var paused = val
	get_tree().paused = paused
	curtain.visible = paused
