extends RigidBody2D


func _ready():
	$CollisionPolygon2D.global_position = $Polygon2D.global_position
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
