extends Area2D

func _physics_process(delta):
	for body in get_overlapping_bodies():
		body.sleeping = false
