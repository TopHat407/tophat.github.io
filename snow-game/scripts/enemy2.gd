extends CharacterBody2D


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var counter = 0

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		globals.enemy2 = 1
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
		queue_free()
