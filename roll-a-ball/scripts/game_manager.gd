extends Node3D

@export var pickup_count : int = 0
@export var game_time : float = 0
@onready var pickups_count_label: Label = $"../pickups_count_label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_created.connect(_on_pickup_created)
	Events.pickup_collected.connect(_on_pickup_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_time += delta
	pickups_count_label.text = "Remaining Pickups: " + str(pickup_count)

func _on_pickup_created() -> void:
	pickup_count += 1
	
func _on_pickup_collected() -> void:
	pickup_count -= 1
