extends Node2D

@export var direction : Vector2
@export var dir_change_time : float = 4
@export var speed : float = 200.0
@export var chase_percent : float = 0.0

@onready var ship: Ship = %Ship

const BORDER :float = 60.0

var vp_rect : Rect2
var parent : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent() as Node2D
	vp_rect = get_viewport_rect()

func chase() -> Vector2:
	return ship.position - position
	
func wander(delta : float) -> Vector2:
	var direction : Vector2
	var chance_of_change = delta / dir_change_time
	
	if (randf() <= chance_of_change):
		direction.x = randi_range(-1, 1)
	if (randf() <= chance_of_change):
		direction.y = randi_range(-1, 1)

	while (direction == Vector2.ZERO):
		direction.x = randi_range(-1, 1)
		direction.y = randi_range(-1, 1)
	
	return direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (parent == null):
		return
	var direction : Vector2
	if (randf() <= chase_percent):
		direction = chase()
	else:
		direction = wander(delta)
	
	# Check for proximity to edge
	if (direction.x < 0 && parent.position.x < BORDER):
		direction.x = 1
	elif (direction.x > 0 && parent.position.x > vp_rect.size.x - BORDER):
		direction.x = -1
		
	if (direction.y < 0 && parent.position.y < BORDER):
		direction.y = 1
	elif (direction.y > 0 && parent.position.y > vp_rect.size.y - BORDER):
		direction.y = -1
		
	parent.position += direction.normalized() * speed * delta
