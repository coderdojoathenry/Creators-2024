extends Node2D

@export var bomb : PackedScene
@export var min_time : float
@export var max_time : float

var time_to_next_bomb : float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_time_to_next_bomb()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_to_next_bomb -= delta
	if (time_to_next_bomb <= 0):
		var new_bomb = bomb.instantiate() as Node2D
		new_bomb.global_position = global_position
		GlobalObjects.SpawnLayer.add_child(new_bomb)
		set_time_to_next_bomb()

func set_time_to_next_bomb() -> void:
	time_to_next_bomb = randf_range(min_time, max_time)
