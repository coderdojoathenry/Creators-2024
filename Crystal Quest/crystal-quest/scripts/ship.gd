extends CharacterBody2D

@export var speed_by_distance : float = 10.0

const DEADZONE : float = 10.0

func _physics_process(delta: float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var ship_to_mouse : Vector2 = mouse_pos - position
	var distance : float = ship_to_mouse.length()

	if (distance > DEADZONE):
		velocity = ship_to_mouse * speed_by_distance
	else:
		velocity = Vector2.ZERO

	move_and_slide()
