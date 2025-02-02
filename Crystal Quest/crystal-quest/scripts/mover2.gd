extends Node2D

@export var speed : float
@export var direction : Vector2
@export var change_at_min : float 
@export var change_at_max : float 

const BORDER :float = 60.0

var parent : Node2D
var vp_rect : Rect2
var time_until_change : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent() as Node2D
	vp_rect = get_viewport_rect()
	time_until_change = randf_range(change_at_min, change_at_max)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_until_change -= delta
	
	# Has it been long enough since last change?
	if (time_until_change < 0.0):
		direction = get_random_direction()
		time_until_change = randf_range(change_at_min, change_at_max)
	
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

func get_random_direction():
	var dir : Vector2
	
	while (dir == Vector2.ZERO):
		dir.x = randi_range(-1, 1)
		dir.y = randi_range(-1, 1)
		
	return dir
