extends Node2D


var current = null



func _on_orb_detect_body_entered(body:RigidBody2D):
	if !is_instance_valid(current) and body.mode == RigidBody2D.MODE_RIGID:
		call_deferred("fill_slot", body)

func fill_slot(body):
	current = body
	body.mode = RigidBody.MODE_STATIC
	body.global_position = global_position
