extends Camera2D


var anchor_point := Vector2()
var anchored := false

func _physics_process(delta):
	if Input.is_action_pressed("follow_ball"):
		var poolstick = Group.get_one("poolstick")
		var selected = poolstick.selected
		if is_instance_valid(selected) and !selected.sleeping:
			global_position = selected.global_position

func _input(event):
	if event.is_action_pressed("anchor_camera"):
#		anchored = true
		anchor_point = get_global_mouse_position()
	elif event.is_action_released("anchor_camera"):
		anchored = false
	elif event is InputEventMouseMotion and anchored:
		var motion_event : InputEventMouseMotion = event
		global_position -= motion_event.relative
