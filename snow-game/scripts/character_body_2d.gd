extends CharacterBody2D
class_name player


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var aud: AudioStreamPlayer = $AudioStreamPlayer


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		aud.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			anim.flip_h = false
		elif velocity.x < 0:
			anim.flip_h = true
		anim.play("run_R")
	else: velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x == 0:
		anim.play("idle")
	
	move_and_slide()
