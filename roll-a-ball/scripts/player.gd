extends RigidBody3D

@export var power : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_collected.connect(_pickup_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	pass

func _physics_process(delta : float) -> void:
	var input = Input.get_vector("Up", "Down", "Left", "Right")
	apply_torque(power * delta * Vector3(input.x, 0, -input.y))

func _pickup_collected() -> void:
	print("I, the player, have been informed that a pickup was collected")
