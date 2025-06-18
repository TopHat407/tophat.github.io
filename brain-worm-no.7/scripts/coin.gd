extends AnimatedSprite2D
var counter = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	counter = 1


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and counter == 1 and globals.debt == 0:
		globals.coins += 1
		self.queue_free()
	elif Input.is_action_just_pressed("interact") and counter == 1 and globals.debt >= 1:
		globals.debt -= 1
		self.queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	counter = 0
