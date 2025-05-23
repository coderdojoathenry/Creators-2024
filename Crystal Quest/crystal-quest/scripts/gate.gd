extends Node2D

@onready var gate_middle: StaticBody2D = $GateMiddle
@onready var exit: Area2D = $Exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalObjects.reset_play_area.connect(_on_reset_play_area)
	GlobalObjects.crystals_cleared.connect(_on_crystals_cleared)
	exit.body_entered.connect(_on_exit_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_exit_entered(body : Node2D) -> void:
	print("_on_exit_entered " + str(body.global_position))
	GlobalObjects.GameManager.level_exited()
	
func _on_reset_play_area() -> void:
	close()
	
func _on_crystals_cleared() -> void:
	open()
	
func open() -> void:
	remove_child(gate_middle)

func close() -> void:
	add_child(gate_middle)
