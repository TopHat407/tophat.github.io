extends CharacterBody2D
class_name player

##movement variables
@export_category("movement variables")
@export var SPEED = 300.0
@export var DASH_SPEED = 500.0
@export var MAX_JUMPS = 1
var JUMP_VELOCITY = -400.0
var JUMPS = MAX_JUMPS
##anim stuff
@onready var anim: Sprite2D = $anim


func _process(float):
	$CanvasLayer/Label.text = "SPEED: " + str(SPEED) + "   " + "JUMPS: " + str(JUMPS) + "   " + "COINS: " + str(globals.coins)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		JUMPS = MAX_JUMPS + globals.coins - 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and JUMPS >= 1:
		velocity.y = JUMP_VELOCITY
		JUMPS -= 1
		globals.coins -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			anim.flip_h = false
		elif velocity.x < 0:
			anim.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("shift"):
		SPEED = DASH_SPEED
	else: SPEED = 300.0

	move_and_slide()
