extends Area2D

@export var DOOR : PackedScene

@onready var door: Area2D = $"."
@onready var anim: AnimatedSprite2D = $anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		anim.play("default")
		await anim.animation_finished
		var instance = DOOR.instantiate()
		get_tree().change_scene_to_file(instance)
