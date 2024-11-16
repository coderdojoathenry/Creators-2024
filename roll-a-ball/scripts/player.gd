extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var input = Input.get_vector("Up", "Down", "Left", "Right")
	apply_torque(Vector3(input.x, 0, -input.y))
