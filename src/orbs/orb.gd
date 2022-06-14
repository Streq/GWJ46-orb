extends RigidBody2D

var been_hit = false setget set_been_hit


func set_been_hit(val):
	been_hit = val
	if !been_hit:
		modulate = Color.white
	else:
		modulate = modulate.linear_interpolate(Color.black, 0.5)

