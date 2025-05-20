extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalObjects.reset_play_area.connect(on_reset_play_area)

func on_reset_play_area() -> void:
	for child in get_children():
		child.queue_free()
