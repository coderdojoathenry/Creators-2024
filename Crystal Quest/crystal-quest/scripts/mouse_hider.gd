extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vp_rect : Rect2 = get_viewport().get_visible_rect()
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	
	if (vp_rect.has_point(mouse_pos)):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
