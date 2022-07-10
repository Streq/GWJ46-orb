extends RigidBody2D

signal sinking()

signal floor_entered()
signal floor_exited()

export var been_hit = false setget set_been_hit

onready var anim = $AnimationPlayer
onready var floor_detect = $floor_detect
onready var skip_sound = $bola_pasa_por_agua

onready var hittable_glow = $hittable_glow
onready var mouseover_particles = $mouseover_particles
onready var mouseover_aura = $mouseover_aura
onready var dead_ball = $modulate/Sprite/been_hit
onready var modulate_node = $modulate
onready var aura = $aura
onready var tween = $Tween
var unsinkable = false

var sinking = false
var magic_particles = false

export var HIT_EXPLOSION: PackedScene


func _ready():
	magic_particles = !been_hit
	update_display()
	set_been_hit(been_hit)
	
func update_display():
	hittable_glow.emitting = magic_particles
	
#	aura.visible = !been_hit

var first_set = true
func set_been_hit(val):
	if first_set:
		first_set = false
		if !hittable_glow:
			yield(self, "ready")
		modulate_node.modulate = Color.white if val else Color(2.0,2.0,2.0)
	#	aura.visible = !val
		
		hittable_glow.visible = !val
	elif been_hit!=val:
		var start
		var end
		var glow_start
		var glow_end
		if val:
			start = Color(2.0,2.0,2.0)
			end = Color.white
		else:
			start = Color.white
			end = Color(2.0,2.0,2.0)

		tween.interpolate_property(modulate_node, "modulate", start, end, 1.0)
#		tween.interpolate_property(hittable_glow, "amount", glow_start, glow_end, 1.0)
		tween.start()
	been_hit = val


func sink():
	if !unsinkable:
		emit_signal("sinking")
		sinking = true
		linear_damp = 10.0
		anim.play("sink")
		hittable_glow.visible = false
#		aura.visible = false
		been_hit = true

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
#	if body is RigidBody2D:
#		print(body.linear_velocity-linear_velocity)
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
	_on_hit(linear_velocity)

func _on_aim():
	_on_mouse_entered()
	mouseover_particles.emitting = !been_hit
	hittable_glow.emitting = magic_particles


func _on_hit(force : Vector2):
#	magic_particles = magic_particles and (!sleeping or !been_hit)
#	update_display()

	var current_glow = modulate_node.modulate.r - 1.0
	if current_glow > 0.0:
		var hit_explosion = HIT_EXPLOSION.instance()
		hit_explosion.global_position = global_position
		hit_explosion.direction = force
		hit_explosion.initial_velocity = force.length()/2.0
		hit_explosion.amount = force.length()/5.0*current_glow
		hit_explosion.emitting = true
		get_tree().current_scene.add_child(hit_explosion)
	
	pass
func _on_mouse_entered():
#	mouseover_particles.visible = !been_hit
	mouseover_aura.visible = !been_hit
	dead_ball.visible = been_hit
#	hittable_glow.emitting = !been_hit

func _on_mouse_exited():
#	mouseover_particles.visible = false
	mouseover_particles.emitting = false
#	hittable_glow.emitting = false
	mouseover_aura.visible = false
	dead_ball.visible = false




func _on_orb_sleeping_state_changed():
	magic_particles = magic_particles and (!been_hit)
	update_display()
