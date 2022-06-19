extends Area2D

export var SKIP_PARTICLES : PackedScene
export var SPLASH_PARTICLES : PackedScene

var skips = {}

const skipping_speed_squared = 750*750

func _physics_process(delta):
	for area in get_overlapping_areas():
		var body : RigidBody2D = area.owner
		if body.floored:
			_remove_skip(body)
		elif !body.sinking:
			if skips.has(body):
				#this sucks but it's cause Area2D's linear_damp seems to be broken
				body.apply_central_impulse(-body.linear_velocity*delta*5)

				if !body.sinking and body.linear_velocity.length_squared() < skipping_speed_squared:
					var splash : CPUParticles2D = SPLASH_PARTICLES.instance()
					splash.emitting = true
					splash.one_shot = true
					body.sink()
					_remove_skip(body)
					body.add_child(splash)
			else:
				_add_skip(body)
			


func _on_water_zone_body_entered(body:RigidBody2D):
	if is_instance_valid(body):
		_add_skip(body)
		
func _on_water_zone_body_exited(body:RigidBody2D):
	if is_instance_valid(body):
		_remove_skip(body)
		if body.sinking:
			body.queue_free()
		

	
func _add_skip(body):
	if !skips.has(body):
		var skip : CPUParticles2D = SKIP_PARTICLES.instance()
		skip.orb = body
		skip.emitting = true
		skip.one_shot = false
		add_child(skip)
		skip._process(0.0)
		skips[body] = skip
		body._on_skipping()

func _remove_skip(body):
	if skips.has(body):
		var skip : CPUParticles2D = skips[body]
		skips.erase(body)
		skip.one_shot = true


func _on_water_zone_area_entered(area):
	_on_water_zone_body_entered(area.owner)

func _on_water_zone_area_exited(area):
	_on_water_zone_body_exited(area.owner)
		
