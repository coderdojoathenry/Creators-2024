class_name GameManager extends Node2D

@export var ship : Node2D
@export var score : int = 0
@export var score_label : Label
@export var explosion_effect : PackedScene

@onready var spawn_layer: Node2D = %SpawnLayer
@onready var respawn_timer = $RespawnTimer

var ship_initial_pos : Vector2
var ship_explosion : Node2D

func _ready() -> void:
	GlobalObjects.GameManager = self
	GlobalObjects.SpawnLayer = spawn_layer
	
	if (ship):
		ship_initial_pos = ship.global_position
	
	if (explosion_effect):
		ship_explosion = explosion_effect.instantiate() as Node2D
		spawn_layer.add_child(ship_explosion)

func _process(delta: float) -> void:
	if (score_label):
		score_label.text = str(score)

func inform_body_entered(body) -> void:
	if (body == ship):
		show_explosion(ship.global_position)
		get_parent().remove_child(ship)
		respawn_timer.start(3)

func show_explosion(where : Vector2) -> void:
	if (ship_explosion):
		ship_explosion.global_position = where
		var particle = ship_explosion.get_child(0) as CPUParticles2D
		particle.emitting = true

func increase_score(amount : int) -> void:
	score = score + amount


func _on_respawn_timer_timeout():
	ship.global_position = ship_initial_pos
	get_parent().add_child(ship)
