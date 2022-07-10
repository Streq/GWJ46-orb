extends CanvasLayer

onready var pivot = $pivot
onready var wait = $wait
onready var retry = $pivot/retry
onready var pause = $pivot/pause
onready var shine = $pivot/retry/shine/shine_anim

func _ready():
	get_tree().connect("tree_changed", self, "_on_tree_changed")



func _on_tree_changed():
	if is_inside_tree():
		var tree = get_tree()
		if is_instance_valid(tree):
			var current_scene = tree.current_scene
			if is_instance_valid(current_scene):
				var currently_in_a_level = current_scene.is_in_group("level")
				pivot.visible = currently_in_a_level


func _physics_process(delta):
	var current_scene = get_tree().current_scene
	if is_instance_valid(current_scene):
		var currently_in_a_level = current_scene.is_in_group("level")
		var all_asleep = true
			
		if currently_in_a_level:
			for orb in Group.get_all("orb"):
				if orb.mode == RigidBody2D.MODE_RIGID and (!orb.sleeping or !orb.been_hit) and !orb.sinking:
					all_asleep = false
					break
		
		var show = currently_in_a_level and all_asleep
		if show:
			if wait.is_stopped():
				wait.start()
		else:
			wait.stop()
			defocus_retry()
		
		
func focus_retry():
	shine.play("shine")

func defocus_retry():
	shine.play("off")

func _on_wait_timeout():
	focus_retry()

func _on_pause_pressed():
	Pause.pause()


func _on_retry_pressed():
	Levels.reload_current_level()

func _on_music_pressed():
	pass


