extends Area2D


func _on_goal_zone_body_entered(body):
	Levels.next_level()
