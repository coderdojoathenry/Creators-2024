extends Node2D

@export var spawn_points : Array[Node2D]
@export var enemies : Array[PackedScene]
@export var max_enemies : int = 4
@export var min_time : float = 2
@export var max_time : float = 10

var next_spawn_time : float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_next_spawn_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_child_count() < max_enemies):
		next_spawn_time -= delta
		if (next_spawn_time <= 0):
			var which_spawn = randi_range(0, spawn_points.size() - 1)
			var which_enemy = randi_range(0, enemies.size() - 1)
			var new_enemy = enemies[which_enemy].instantiate() as Node2D
			new_enemy.global_position = spawn_points[which_spawn].global_position
			add_child(new_enemy)
			set_next_spawn_time()

func set_next_spawn_time() -> void:
	next_spawn_time = randf_range(min_time, max_time)
