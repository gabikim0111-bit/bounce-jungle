extends CharacterBody2D

@export var SPEED = 60.0

var direction = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ground_right = $GroundRight
@onready var ground_left = $GroundLeft

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Turn around when hitting a wall or when the ground ahead runs out.
		var wall = ray_cast_right if direction > 0 else ray_cast_left
		var ground = ground_right if direction > 0 else ground_left
		if wall.is_colliding() or not ground.is_colliding():
			direction = -direction

	animated_sprite.flip_h = direction < 0
	velocity.x = direction * SPEED
	move_and_slide()
