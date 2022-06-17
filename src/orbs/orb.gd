extends RigidBody2D

signal sinking()

signal floor_entered()
signal floor_exited()

export var been_hit = false setget set_been_hit

onready var anim = $AnimationPlayer
onready var floor_detect = $floor_detect

var sinking = false

func set_been_hit(val):
	been_hit = val
	if !been_hit:
		$modulate.modulate = Color.white
	else:
		$modulate.modulate = Color.white.darkened(0.5)

func sink():
	emit_signal("sinking")
	sinking = true
	linear_damp = 10.0
	anim.play("sink")

func is_on_floor():
	floor_detect.get_overlapping_areas().size()>0

var floored = false
func _on_floor_detect_area_entered(area):
	if !floored:
		emit_signal("floor_entered")
	floored = true

func _on_floor_detect_area_exited(area):
	if floored and floor_detect.get_overlapping_areas().size() == 0:
		floored = false
		emit_signal("floor_exited")
