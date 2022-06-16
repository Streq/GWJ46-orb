extends Area2D

export var SKIP_PARTICLES : PackedScene
export var SPLASH_PARTICLES : PackedScene

var skips = {}

const skipping_speed_squared = 750*750

func _physics_process(delta):
	for _body in get_overlapping_bodies():
		var body : RigidBody2D = _body
		#this sucks but it's cause Area2D's linear_damp seems to be broken
		body.apply_central_impulse(-body.linear_velocity*delta*5)

		if body.linear_velocity.length_squared() < skipping_speed_squared:
			var splash : CPUParticles2D = SPLASH_PARTICLES.instance()
			splash.emitting = true
			splash.one_shot = true
			body.sink()
			body.add_child(splash)
			


func _on_water_zone_body_entered(body:RigidBody2D):
	if is_instance_valid(body):
		var skip : CPUParticles2D = SKIP_PARTICLES.instance()
		skip.orb = body
		skip.emitting = true
		skip.one_shot = false
		add_child(skip)
		skip._process(0.0)
		skips[body] = skip


func _on_water_zone_body_exited(body:RigidBody2D):
	if skips.has(body):
		var skip : CPUParticles2D = skips[body]
		skips.erase(body)
		skip.one_shot = true
		
	if body.sinking:
		body.queue_free()
