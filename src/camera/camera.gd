extends Camera2D


var anchor_point := Vector2()
var anchored := false


func _input(event):
	if event.is_action_pressed("anchor_camera"):
		anchored = true
		anchor_point = get_global_mouse_position()
	elif event.is_action_released("anchor_camera"):
		anchored = false
	elif event is InputEventMouseMotion and anchored:
		var motion_event : InputEventMouseMotion = event
		offset -= motion_event.relative
