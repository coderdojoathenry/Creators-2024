class_name Missile extends Area2D

@export var direction : Vector2
@export var speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	rotation = Vector2.UP.angle_to(direction)

func _on_timer_timeout() -> void:
	queue_free()
