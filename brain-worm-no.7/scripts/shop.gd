extends Area2D

var counter = 0

func _on_body_entered(body: Node2D) -> void:
	counter = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and counter == 1:
		get_tree().change_scene_to_file("res://scenes/inside_shop.tscn")


func _on_body_exited(body: Node2D) -> void:
	counter = 0
