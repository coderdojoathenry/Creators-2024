extends Node2D

@export var direction : Vector2
@export var speed : float
@export var wander_time_min : float
@export var wander_time_max : float
@export var border : Border

var parent : Node2D
var vp_rect : Rect2
var wander_change_dir_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent() as Node2D
	vp_rect = get_viewport_rect() 
	set_wander_change_dir_time()

func set_wander_change_dir_time() -> void:
	wander_change_dir_time = randf_range(wander_time_min, wander_time_max)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (parent == null):
		return
	
	wander_change_dir_time -= delta
	
	if (wander_change_dir_time < 0):
		pick_random_direction()
		set_wander_change_dir_time()
		
	correct_dir_for_bounds()
	parent.position += direction.normalized() * speed * delta

func correct_dir_for_bounds() -> void:
	var top = 0
	var bottom = 0
	var left = 0
	var right = 0
	
	if (border):
		top = border.Top
		bottom = border.Bottom
		left = border.Left
		right = border.Right
	
	if (direction.x < 0 && parent.position.x < left):
		direction.x = 1
	if (direction.x > 0 && parent.position.x > vp_rect.size.x - right):
		direction.x = -1
	if (direction.y < 0 && parent.position.y < top):
		direction.y = 1
	if (direction.y > 0 && parent.position.y > vp_rect.size.y - bottom):
		direction.y = -1

func pick_random_direction() -> void:
	direction = Vector2.ZERO
	while (direction == Vector2.ZERO):
		direction.x = randi_range(-1, 1)
		direction.y = randi_range(-1, 1)
