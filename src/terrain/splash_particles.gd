extends CPUParticles2D


func _physics_process(delta):
	global_rotation = 0


func _on_Timer_timeout():
	queue_free()
