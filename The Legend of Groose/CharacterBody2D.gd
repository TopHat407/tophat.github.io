extends CharacterBody2D
var speed = 100
var last_direction = Vector2.ZERO
var animated_sprite
func _ready():
	animated_sprite = $AnimatedSprite2D
	add_to_group("Player")
func _physics_process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	if direction != Vector2.ZERO:
		last_direction = direction
		if direction.x != 0:
			animated_sprite.play("walk_right")
		elif direction.y < 0:
			animated_sprite.play("walk_up")
		elif direction.y > 0:
			animated_sprite.play("walk_down")
	else:
		if last_direction.x != 0:
			animated_sprite.play("idle_right")
		elif last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
	animated_sprite.flip_h = last_direction.x < 0
	move_and_slide()


func _on_area_2d_body_entered(_body):
	pass # Replace with function body.


func _on_area_2d_body_exited(_body):
	pass # Replace with function body.
