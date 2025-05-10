extends AnimatableBody2D

@export var direction : Vector2
@export var speed : float
@export var wander_time_min : float
@export var wander_time_max : float
@export var score : int = 100
@export var persuit_percent : float = 0

var vp_rect : Rect2
var wander_change_dir_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vp_rect = get_viewport_rect() 
	set_wander_change_dir_time()
	tree_exiting.connect(_on_tree_exiting)

func set_wander_change_dir_time() -> void:
	wander_change_dir_time = randf_range(wander_time_min, wander_time_max)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wander_change_dir_time -= delta
	
	if (wander_change_dir_time < 0):
		pick_direction()
		set_wander_change_dir_time()
	
func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(direction.normalized() * speed * delta)
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
	

func pick_direction() -> void:
	if (randf() < persuit_percent && GlobalObjects.GameManager.ship != null):
		direction = GlobalObjects.GameManager.ship.position - position
	else:
		pick_random_direction()

func pick_random_direction() -> void:
	direction = Vector2.ZERO
	while (direction == Vector2.ZERO):
		direction.x = randi_range(-1, 1)
		direction.y = randi_range(-1, 1)

func _on_tree_exiting() -> void:
	GlobalObjects.GameManager.increase_score(score)
