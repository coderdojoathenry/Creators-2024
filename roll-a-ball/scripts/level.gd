extends Node3D
class_name Level

@export var target_seconds : float

func _ready() -> void:
	var bounds = find_child("Bounds")
	if (bounds != null):
		bounds.hide()
