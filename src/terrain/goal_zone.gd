extends Area2D

var won = false
onready var acorde = $acorde
onready var buchaca = $buchaca

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("can_win_with"):
			
			body.apply_central_impulse(-body.linear_velocity*delta*10)


func _on_goal_zone_body_entered(body):
	if body.is_in_group("can_win_with") and !won:
		won = true
		buchaca.play()
#		Music.play_music("nothing")
		acorde.play()
		
		get_tree().create_timer(2.0).connect("timeout",self,"win")
		

func win():
#	Music.play_music("gameplay")
	Levels.next_level()
