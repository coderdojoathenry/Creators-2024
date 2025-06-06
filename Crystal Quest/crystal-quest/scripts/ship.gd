extends CharacterBody2D

@export var speed_by_distance : float = 10.0
@export var missile_scene : PackedScene
@export var min_time_between_missiles : float = 0.1

const DEADZONE : float = 10.0
const MISSILE_OFFSET : int = 32

@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound
@onready var destroy_sound: AudioStreamPlayer2D = $DestroySound

var missile_countdown : float = 0
var last_non_zero_dir : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	missile_countdown -= delta
	
	if (Input.is_action_just_pressed("Shoot") && missile_countdown < 0):
		var new_missile = missile_scene.instantiate() as Missile

		new_missile.direction = velocity.normalized()
		if (new_missile.direction == Vector2.ZERO):
			new_missile.direction = last_non_zero_dir
			
		new_missile.position = position + \
							   new_missile.direction * MISSILE_OFFSET
		
		GlobalObjects.SpawnLayer.add_child(new_missile)
		missile_countdown = min_time_between_missiles
		shoot_sound.play()

func _physics_process(delta: float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var ship_to_mouse : Vector2 = mouse_pos - position
	var distance : float = ship_to_mouse.length()

	if (distance > DEADZONE):
		velocity = ship_to_mouse * speed_by_distance
		last_non_zero_dir = velocity.normalized()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_obj = collision.get_collider() as CollisionObject2D
		if (collision_obj && \
			collision_obj.get_collision_layer_value(2) == false):
			GlobalObjects.GameManager.inform_body_entered(self)
