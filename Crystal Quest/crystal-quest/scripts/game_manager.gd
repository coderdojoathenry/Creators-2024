class_name GameManager extends Node2D

@export var ship : Node2D
@export var score : int = 0
@export var score_label : Label

@onready var spawn_layer: Node2D = %SpawnLayer

func _ready() -> void:
	GlobalObjects.GameManager = self
	GlobalObjects.SpawnLayer = spawn_layer

func _process(delta: float) -> void:
	if (score_label):
		score_label.text = str(score)

func inform_body_entered(body) -> void:
	if (body == ship):
		ship.queue_free()

func increase_score(amount : int) -> void:
	score = score + amount
