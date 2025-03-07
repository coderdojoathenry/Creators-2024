class_name Missile extends Area2D

@export var Direction : Vector2 = Vector2.UP
@export var Speed : float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = Vector2.UP.angle_to(Direction)
	position += Direction * Speed * delta

func _on_body_entered(body : Area2D) -> void:
	body.queue_free()

func _on_timer_timeout():
	queue_free()
