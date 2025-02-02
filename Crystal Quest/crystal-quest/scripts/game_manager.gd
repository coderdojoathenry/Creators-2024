extends Node

@export var ship : Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func kill_ship_entered(body):
	if (body == ship):
		ship.queue_free()
