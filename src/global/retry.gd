extends CanvasLayer

onready var pivot = $pivot
onready var wait = $wait



func _physics_process(delta):
	var current_scene = get_tree().current_scene
	if is_instance_valid(current_scene):
		var currently_in_a_level = current_scene.is_in_group("level")
		var all_asleep = true
			
		if currently_in_a_level:
			for orb in Group.get_all("orb"):
				if orb.mode == RigidBody2D.MODE_RIGID and (!orb.sleeping or !orb.been_hit):
					all_asleep = false
					break
		
		var show = currently_in_a_level and all_asleep
		if show:
			if wait.is_stopped():
				wait.start()
		else:
			wait.stop()
			pivot.visible = false
		
		

func _on_wait_timeout():
	pivot.visible = true
