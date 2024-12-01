extends Node3D

@export var pickup_count : int = 0
@export var level : Array[PackedScene]

@onready var time_remaining_label: Label = $"../UI/time_remaining_label"
@onready var game_over_label: Label = $"../UI/game_over_label"
@onready var pickups_count_label: Label = $"../UI/pickups_count_label"
@onready var player: RigidBody3D = $"../Player"

var time_remaining : float = -1.0

var current_level : Level
var current_level_index : int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_created.connect(_on_pickup_created)
	Events.pickup_collected.connect(_on_pickup_collected)
	game_over_label.hide()


func load_next_level() -> bool:
	if (current_level != null):
		current_level.queue_free()

	current_level_index += 1
	if (current_level_index >= len(level)):
		return false

	current_level = level[current_level_index].instantiate() as Level
	time_remaining = current_level.target_seconds
	add_child(current_level)

	return true


func restart() -> void:
	pickups_count_label.show()
	time_remaining_label.show()
	game_over_label.hide()
	
	current_level_index = -1
	if (current_level != null):
		current_level.queue_free()
		current_level = null
	
	player.show()
	player.reset_requested = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_remaining -= delta
	pickups_count_label.text = "Remaining Pickups: " + str(pickup_count)
	if (time_remaining < 0.0):
		time_remaining_label.text = "Time Remaining: 0.0s"
	else:
		time_remaining_label.text = "Time Remaining: " + str(time_remaining).pad_decimals(1) + "s"
	
	if (pickup_count == 0):
		if (current_level != null && time_remaining < 0):
			show_game_over("Too slow. Restart?")
		elif (load_next_level()):
			player.reset_requested = true
		else:
			show_game_over("You won! Restart?")


func show_game_over(msg : String) -> void:
			player.hide()
			pickups_count_label.hide()
			time_remaining_label.hide()
			game_over_label.text = msg
			game_over_label.show()

func _on_pickup_created() -> void:
	pickup_count += 1

	
func _on_pickup_collected() -> void:
	pickup_count -= 1


func _on_restart_button_pressed() -> void:
	restart()
