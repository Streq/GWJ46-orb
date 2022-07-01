extends Node2D

export (int, LAYERS_2D_PHYSICS) var layers


onready var tween = $Tween
onready var poolstick = $poolstick

var selected : RigidBody2D = null

#global point where player clicked on the selected RigidBody2D
var point_of_impulse := Vector2()
#global point where player released on the selected RigidBody2D
var point_of_release := Vector2()



const IDLE = 0
const AIMING = 1
const SHOOTING = 2

var state = IDLE

var mouse_pos := Vector2()

export var max_dist := 256.0
export var impulse_multiplier = 1200.0

onready var hit_sound := $hit_sound

func _ready():
	_change_state(IDLE)

func _physics_process(delta):
	
	if is_instance_valid(selected):
		selected._on_mouse_exited()
	mouse_pos = get_global_mouse_position()
	match state:
		IDLE:
			# get the Physics2DDirectSpaceState object
			var space = get_world_2d().direct_space_state
			# Get the mouse's position
			# Check if there is a collision at the mouse position
			var orbs = space.intersect_point(mouse_pos, 1, [], layers)
			if orbs:
#				print("hit something")
				selected = orbs[0].collider
				if selected.sleeping or selected.linear_velocity.is_equal_approx(Vector2.ZERO) and !selected.been_hit:
					selected._on_mouse_entered()
					if Input.is_action_just_pressed("selected"):
						point_of_impulse = selected.global_position
						_change_state(AIMING)
						
				
			else:
				pass
#				print("no hit")
		AIMING:
			poolstick.global_position = Math.clamp_to_radius(mouse_pos, point_of_impulse, max_dist)
			poolstick.global_rotation = point_of_impulse.angle_to_point(mouse_pos)
			point_of_release = poolstick.global_position
			if Input.is_action_just_released("selected"):
				_change_state(SHOOTING)
			elif Input.is_action_just_pressed("anchor_camera"):
				_change_state(IDLE)
		SHOOTING:
			pass
	update()
	

func _draw():
	match state:
		AIMING:
			var power = get_power()
			var color = Color.green.linear_interpolate(Color.red, power)
			draw_line(poolstick.position, to_local(point_of_impulse), color)
			draw_line(to_local(point_of_impulse), to_local(point_of_impulse + poolstick.global_position.direction_to(point_of_impulse)*128.0), color)
			

func get_power():
	return (point_of_release-point_of_impulse).length()/max_dist

func _change_state(new_state:int):
	state = new_state
	match state:
		IDLE:
			poolstick.visible = false
		AIMING:
			poolstick.visible = true
			poolstick.global_position = mouse_pos
		SHOOTING:
			tween.interpolate_property(poolstick, "global_position", point_of_release, point_of_impulse, 0.1)
			tween.start()
			yield(tween, "tween_all_completed")
			var impulse = get_power()*impulse_multiplier
			if selected.sleeping or selected.linear_velocity.is_equal_approx(Vector2.ZERO):
				selected.apply_impulse(selected.to_local(point_of_impulse), (point_of_impulse-point_of_release).normalized()*impulse)
				selected.been_hit = true
				hit_sound.play()
				get_tree().create_timer(0.3).connect("timeout", self, "_change_state", [IDLE])
			else:
				_change_state(IDLE)
			
