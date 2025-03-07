extends CharacterBody2D

@export var speed_by_distance : float = 10.0
@export var missile : PackedScene
@export var min_time_between_missiles : float = 1.0

const DEADZONE : float = 10.0
const MISSILE_OFFSET : float = 32
 
var missile_countdown : float = 0.0

func _process(delta):
	missile_countdown -= delta
	
	if (Input.is_action_pressed("Shoot") && missile && missile_countdown < 0):
		var new_missile = missile.instantiate() as Missile
		new_missile.position = position + velocity.normalized() * MISSILE_OFFSET
		new_missile.Direction = velocity.normalized()
		if (new_missile.Direction == Vector2.ZERO):
			new_missile.Direction = Vector2(1, 0)
		get_parent().add_child(new_missile)
		missile_countdown = min_time_between_missiles
		

func _physics_process(delta: float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var ship_to_mouse : Vector2 = mouse_pos - position
	var distance : float = ship_to_mouse.length()

	if (distance > DEADZONE):
		velocity = ship_to_mouse * speed_by_distance
	else:
		velocity = Vector2.ZERO

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider() as PhysicsBody2D
		if (body && body.get_collision_layer_value(2)):
			body.queue_free()
		

	move_and_slide()
