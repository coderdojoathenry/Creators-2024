class_name Level extends Node2D

@export var bonus_time : float = 4.0

var level_cleared : bool = false
@onready var crystals = $Crystals

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bonus_time -= delta
	if (crystals.get_child_count() == 0 && level_cleared == false):
		level_cleared = true
		GlobalObjects.crystals_cleared.emit()
