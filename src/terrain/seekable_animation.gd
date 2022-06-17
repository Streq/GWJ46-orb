extends AnimationPlayer

export var seek_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(owner, "ready")
	seek(seek_time,true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
