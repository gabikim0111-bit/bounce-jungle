extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = 600.0
@onready var ray_cast=$RayCast2D
@onready var ray_cast2=$RayCast2D2
@onready var ray_cast3=$RayCast2D3
@onready var jump_sound=$JumpSound

var was_bouncing = false

@warning_ignore("unused_parameter")
func _process(delta) -> void:
	var bouncing = ray_cast.is_colliding() or ray_cast2.is_colliding() or ray_cast3.is_colliding()
	if bouncing:
		velocity=Vector2.UP*JUMP_VELOCITY
		# only on the first frame of the bounce, otherwise it fires every frame
		if not was_bouncing:
			jump_sound.play()
	was_bouncing = bouncing

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
