extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_created.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	print(body.name + " entered the area")
	queue_free()
	Events.pickup_collected.emit()
