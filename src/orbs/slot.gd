extends Node2D

onready var sprite_empty = $Sprite
onready var sprite_activated = $Sprite2
onready var sprite_locked = $sprite_locked

var current = null

onready var buchaca = $buchaca

func _on_orb_detect_body_entered(body:RigidBody2D):
	if !is_instance_valid(current) and body.mode == RigidBody2D.MODE_RIGID:
		call_deferred("fill_slot", body)
	
func fill_slot(body):
	body.unsinkable = true
	sprite_empty.visible = false
	sprite_activated.visible = true
	sprite_locked.visible = true
	NodeUtils.reparent(body, self)

	buchaca.play()
	current = body
	body.mode = RigidBody.MODE_STATIC
	body.global_position = global_position
	
