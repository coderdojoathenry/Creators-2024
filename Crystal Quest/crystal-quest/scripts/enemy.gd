extends AnimatableBody2D

@export var direction : Vector2
@export var speed : float
@export var wander_time_min : float
@export var wander_time_max : float

var vp_rect : Rect2
var wander_change_dir_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vp_rect = get_viewport_rect() 
	set_wander_change_dir_time()

func set_wander_change_dir_time() -> void:
	wander_change_dir_time = randf_range(wander_time_min, wander_time_max)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wander_change_dir_time -= delta
	
	if (wander_change_dir_time < 0):
		pick_random_direction()
		set_wander_change_dir_time()
	
func _physics_process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta
	var collision = move_and_collide(direction)
	if (collision):
		var collision_pos = collision.get_position()
		
		if (direction.x < 0 && collision_pos.x < global_position.x):
			direction.x = 1
		if (direction.x > 0 && collision_pos.x > global_position.x):
			direction.x = -1
			
		if (direction.y < 0 && collision_pos.y < global_position.y):
			direction.y = 1
		if (direction.y > 0 && collision_pos.y > global_position.y):
			direction.y = -1
	

func pick_random_direction() -> void:
	direction = Vector2.ZERO
	while (direction == Vector2.ZERO):
		direction.x = randi_range(-1, 1)
		direction.y = randi_range(-1, 1)
