extends CanvasLayer

onready var pivot = $pivot

func _ready():
	set_pause(get_tree().paused)

func _input(event):
	if event.is_action_pressed("pause"):
		if !get_tree().current_scene.is_in_group("menu"):
			set_pause(!get_tree().paused)

func set_pause(val):
	var paused = val
	get_tree().paused = paused
	pivot.visible = paused

func pause():
	set_pause(true)
func unpause():
	set_pause(false)
