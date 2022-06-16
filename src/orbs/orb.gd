extends RigidBody2D

export var been_hit = false setget set_been_hit

onready var anim = $AnimationPlayer
var sinking = false

func set_been_hit(val):
	been_hit = val
	if !been_hit:
		$modulate.modulate = Color.white
	else:
		$modulate.modulate = Color.white.darkened(0.5)

func sink():
	sinking = true
	linear_damp = 10.0
	anim.play("sink")
