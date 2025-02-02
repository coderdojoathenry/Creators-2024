extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area2d_parent = get_parent() as Area2D
	
	if (area2d_parent):
		area2d_parent.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	%GameManager.kill_ship_entered(body)
