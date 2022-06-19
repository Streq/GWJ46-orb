extends RigidBody2D

signal sinking()

signal floor_entered()
signal floor_exited()

export var been_hit = false setget set_been_hit

onready var anim = $AnimationPlayer
onready var floor_detect = $floor_detect
onready var skip_sound = $bola_pasa_por_agua

var unsinkable = false

var sinking = false

func set_been_hit(val):
	been_hit = val
	if !been_hit:
		$modulate.modulate = Color.white
	else:
		$modulate.modulate = Color.white.darkened(0.5)

func sink():
	if !unsinkable:
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

func _on_skipping():
	if linear_velocity.length_squared() > 750*750:
		skip_sound.play()


func _on_orb_body_entered(body):
	if body is RigidBody2D:
		print(body.linear_velocity-linear_velocity)
	var max_speed = 1200
#	max_speed = max_speed*max_speed
	var loudness = min(linear_velocity.length(), max_speed)/max_speed
	#-80db equivale a 0
	#0db equivale a 1200*1200
	#-80/1200*1200
	if loudness > 0.2:
		if body.is_in_group("orb"):
			$golpe_bola.volume_db = (loudness-1)*10.0
			$golpe_bola.playing = true
		else:
			$rebote.volume_db = (loudness-1)*10.0
			$rebote.playing = true
		
