extends Area2D

var counter = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and counter == 1:
		if globals.coins >= 4:
			globals.item += 1
			globals.coins -= 4
			self.queue_free()
		elif globals.coins < 4:
			globals.item += 1
			globals.debt += 4
			self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	counter = 1


func _on_body_exited(body: Node2D) -> void:
	counter = 0
