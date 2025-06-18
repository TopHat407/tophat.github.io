extends Node2D

@onready var aud: AudioStreamPlayer = $AudioStreamPlayer
@export var enemy_attacked : Node2D

func _ready() -> void:
	if globals.enemy1 == 2:
		$enemy.queue_free()
	if globals.enemy2 == 2:
		$enemy2.queue_free()
	if globals.enemy3 == 2:
		$enemy3.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
