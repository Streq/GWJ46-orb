extends Node2D


export var seek := 0.0

func _ready():
	$AnimationPlayer.seek(seek, true)
	pass
