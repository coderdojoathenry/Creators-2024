extends RigidBody3D

@export var power : float = 1.0

@onready var sound: AudioStreamPlayer3D = $Sound

var initial_pos : Vector3
var initial_rot : Vector3

var reset_requested : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_collected.connect(_pickup_collected)
	initial_pos = position
	initial_rot = rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass

func _physics_process(delta : float) -> void:
	if (reset_requested):
		position = initial_pos
		rotation = initial_rot
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		reset_requested = false
	else:
		var input = Input.get_vector("Up", "Down", "Left", "Right")
		apply_torque(power * delta * Vector3(input.x, 0, -input.y))

func _pickup_collected() -> void:
	sound.play()
