extends CharacterBody2D
var speed = 50
const SPEED = 300.0
var last_direction = Vector2.ZERO
var min_position = Vector2(-192,-112)
var max_position = Vector2(192, 112)
var direction_change_timer = 0
var direction_change_interval = 5
func _ready():
	pick_random_direction()
func _physics_process(delta):
	if direction_change_timer >= direction_change_interval:
		pick_random_direction()
		direction_change_timer = 0
		
		velocity = last_direction * speed

	move_and_slide()

	var old_position = position
	position.x = clamp(position.x, min_position.x, max_position.x)
	position.y = clamp(position.y, min_position.y, max_position.y)

	if old_position != position:
		last_direction = -last_direction
		
func pick_random_direction():
	var new_direction = Vector2.ZERO
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction
	
	
