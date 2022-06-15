extends Area2D


func _on_goal_zone_body_entered(body):
	if body.is_in_group("can_win_with"):
		Levels.next_level()
