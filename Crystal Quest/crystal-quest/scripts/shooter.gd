extends Node2D

@export var projectile : PackedScene
@export var min_shot_time : float
@export var max_shot_time : float

var time_to_next_shot : float

@onready var projectile_layer: Node2D = %ProjectileLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_next_shot_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_to_next_shot -= delta
	
	if (time_to_next_shot < 0 && projectile != null):
		var new_projectile = projectile.instantiate() as Node2D
		new_projectile.position = position
		projectile_layer.add_child(new_projectile)
		set_next_shot_time()

func set_next_shot_time() -> void:
	time_to_next_shot = randf_range(min_shot_time,\
									max_shot_time)
