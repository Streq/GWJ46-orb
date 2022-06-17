extends RigidBody2D


func _ready():
	$CollisionPolygon2D.transform = $Polygon2D.transform
	$CollisionPolygon2D.polygon = $Polygon2D.polygon
