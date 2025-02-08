extends Node2D

@export var ship : Node2D

func inform_body_entered(body) -> void:
	if (body == ship):
		ship.queue_free()
