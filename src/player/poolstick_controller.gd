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
var impulse_multiplier = 600.0

func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	match state:
		IDLE:
			# get the Physics2DDirectSpaceState object
			var space = get_world_2d().direct_space_state
			# Get the mouse's position
			# Check if there is a collision at the mouse position
			var orbs = space.intersect_point(mouse_pos, 1, [], layers)
			if orbs:
				print("hit something")
				selected = orbs[0].collider
				if selected.sleeping:
					if Input.is_action_just_pressed("selected"):
#						point_of_impulse = mouse_pos
						point_of_impulse = selected.global_position
						_change_state(AIMING)
				
			else:
				print("no hit")
		AIMING:
			poolstick.global_position = mouse_pos
			poolstick.global_rotation = point_of_impulse.angle_to_point(mouse_pos)
			var power =  get_power()
			if power>1:
				poolstick.global_position = point_of_impulse+(mouse_pos-point_of_impulse)/power
			
			if Input.is_action_just_released("selected"):
				point_of_release = mouse_pos
				_change_state(SHOOTING)
		SHOOTING:
			pass
	update()
	

func _draw():
	match state:
		AIMING:
			var power = get_power()
			var color = Color.green.linear_interpolate(Color.red, power)
			draw_line(poolstick.position, point_of_impulse, color)

func get_power():
	return (mouse_pos-point_of_impulse).length()/max_dist

func _change_state(new_state:int):
	state = new_state
	match state:
		IDLE:
			poolstick.visible = false
		AIMING:
			poolstick.visible = true
			poolstick.global_position = mouse_pos
		SHOOTING:
			tween.interpolate_property(poolstick, "global_position", poolstick.global_position, point_of_impulse, 0.1)
			tween.start()
			yield(tween, "tween_all_completed")
			var impulse = get_power()*impulse_multiplier
			selected.apply_impulse(selected.to_local(point_of_impulse), (point_of_impulse-point_of_release).normalized()*impulse)
			yield(get_tree().create_timer(0.3),"timeout")
			_change_state(IDLE)
			
