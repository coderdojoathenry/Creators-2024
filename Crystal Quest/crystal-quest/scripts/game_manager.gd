class_name GameManager extends Node2D

@export var ship : Node2D
@export var score : int = 0
@export var score_label : Label
@export var game_over_label : Label
@export var explosion_effect : PackedScene
@export var respawn_delay : float = 3.0
@export var life_icons : Array[Control]
@export var levels : Array[PackedScene]
@export var bonus_speed_label: Label

@onready var spawn_layer: Node2D = %SpawnLayer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var destroy_sound: AudioStreamPlayer2D = $DestroySound
@onready var collect_sound: AudioStreamPlayer2D = $CollectSound
@onready var base_left : Node2D = $"../Environment/Base_left"
@onready var base_right : Node2D = $"../Environment/Base_right"
@onready var next_level_timer: Timer = $NextLevelTimer
@onready var success_sound: AudioStreamPlayer2D = $SuccessSound

var ship_initial_position : Vector2
var explosion_instance : Node2D
var max_lives : int = 5
var lives : int = 3
var ship_destroyed : bool = false
var level_number : int = -1
var current_level : Level

func _ready() -> void:
	GlobalObjects.GameManager = self
	GlobalObjects.SpawnLayer = spawn_layer
	GlobalObjects.BaseLeft = base_left
	GlobalObjects.BaseRight = base_right
	
	GlobalObjects.crystals_cleared.connect(_on_level_cleared)
	
	if (ship):
		ship_initial_position = ship.global_position
		
	if (explosion_effect):
		explosion_instance = explosion_effect.instantiate() as Node2D
		add_child(explosion_instance)
	
	load_next_level()

func _process(delta: float) -> void:
	if (score_label):
		score_label.text = "Score: " + str(score)
	update_life_icons()

func update_life_icons() -> void:
	for i in range(0, max_lives):
		if (i >= lives):
			life_icons[i].hide()
		else:
			life_icons[i].show()
		

func inform_body_entered(body) -> void:
	if (body == ship && ship_destroyed == false):
		get_parent().remove_child(ship)
		ship_destroyed = true
		destroy_sound.play()
		explosion_instance.global_position = ship.global_position
		var exp = explosion_instance.get_child(0) as CPUParticles2D
		exp.emitting = true
		respawn_timer.start(respawn_delay)
		lives = lives - 1

func increase_score(amount : int) -> void:
	score = score + amount

func collect(amount : int) -> void:
	increase_score(amount)
	collect_sound.play()

func increase_lives() -> void:
	if (lives < max_lives):
		lives += 1

func _on_respawn_timer_timeout() -> void:
	if (lives > 0):
		GlobalObjects.reset_play_area.emit()
		ship.global_position = ship_initial_position
		get_parent().add_child(ship)
		ship_destroyed = false
	else:
		game_over_label.show()

func _on_level_cleared() -> void:
	print_debug("Level cleared")

func level_exited() -> void:
	get_parent().remove_child(ship)
	ship_destroyed = true
	if (current_level.bonus_time > 0.0):
		increase_score(50000)
		bonus_speed_label.show()
	next_level_timer.start(4)
	GlobalObjects.reset_play_area.emit()
	success_sound.play()
	
func load_next_level() -> void:
	if (current_level != null):
		current_level.queue_free()
	level_number += 1
	var effective_level = level_number % levels.size()
	current_level = levels[effective_level].instantiate() as Level
	add_child(current_level)


func _on_next_level_timer_timeout() -> void:
	bonus_speed_label.hide()
	load_next_level()
	ship.global_position = ship_initial_position
	get_parent().add_child(ship)
	ship_destroyed = false
