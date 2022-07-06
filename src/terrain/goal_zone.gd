extends Area2D

var won = false
onready var acorde = $acorde
onready var buchaca = $buchaca

var already_in = []

func _physics_process(delta):
	pass
	for body in get_overlapping_bodies():
#		if body.is_in_group("can_win_with"):
		body.apply_central_impulse(-body.linear_velocity*delta*10)
		pass
#	for body in $goal.get_overlapping_bodies():
#		body.apply_central_impulse(-body.linear_velocity*delta*30)

func _on_goal_body_entered(body):
	if !already_in.has(body):
		already_in.append(body)
		body.unsinkable = true
		body.set_collision_layer_bit(7, true)
		
		NodeUtils.reparent_keep_transform(body, self)
	#		body.position = Vector2()
		buchaca.play()
		
		if body.is_in_group("can_win_with") and !won:
			won = true
	#		Music.play_music("nothing")
			for goal in Group.get_all("goal"):
				if !goal.won:
					return
			acorde.play()
			get_tree().create_timer(2.0).connect("timeout",self,"win")
		

func win():
#	Music.play_music("gameplay")
	Levels.next_level()
