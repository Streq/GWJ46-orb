extends RigidBody2D

var been_hit = false setget set_been_hit


func set_been_hit(val):
	been_hit = val
	if !been_hit:
		$modulate.modulate = Color.white
	else:
		$modulate.modulate = Color.white.darkened(0.5)

