class_name Missile extends Area2D

@export var direction : Vector2
@export var speed : float
@onready var sound: AudioStreamPlayer2D = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	rotation = Vector2.UP.angle_to(direction)

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body : Node2D):
	body.queue_free()
	sound.play()
