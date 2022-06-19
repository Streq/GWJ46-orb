extends Area2D

func _physics_process(delta):
	for body in get_overlapping_bodies():
		body.sleeping = false
onready var sound = $repel_sound




func _on_repulsion_area_body_exited(body):
	sound.play()
