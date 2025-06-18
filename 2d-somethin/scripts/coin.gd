extends AnimatedSprite2D
@onready var anim: AnimatedSprite2D = $"."
@onready var aud: AudioStreamPlayer = $aud


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		globals.coins += 1
		queue_free()
