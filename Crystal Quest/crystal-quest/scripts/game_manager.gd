class_name GameManager extends Node2D

@export var ship : Node2D
@export var score : int = 0

func inform_body_entered(body) -> void:
	if (body == ship):
		ship.queue_free()

func increase_score(amount : int) -> void:
	score += amount
