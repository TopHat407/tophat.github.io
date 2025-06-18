extends CharacterBody2D


var SPEED = 400.0
@onready var sprite: Sprite2D = $Sprite2D



func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("shift"):
		SPEED = 600
	else:
		SPEED = 400
	if direction and globals.no_move == 0 and globals.control == 2:
		velocity = direction * SPEED
		if direction.x <= -1:
			sprite.flip_h = false
		elif direction.x >= 1:
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	

	move_and_slide()
