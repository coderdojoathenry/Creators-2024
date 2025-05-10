extends Area2D

func _on_body_entered(body: Node2D) -> void:
	GlobalObjects.GameManager.inform_body_entered(body)
