extends CharacterBody2D
class_name player

@export var SPEED = 300.0
@export var kb_power = 500

@onready var health: TextureProgressBar = $CanvasLayer/health



func _ready() -> void:
	health.value = 100


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	if !direction:
		move_toward(velocity.x, 0, 10)
		move_toward(velocity.y, 0, 10)
	move_and_slide()

func handle_damage(area):
	health.value -= 15
	knockback(area.get_parent().velocity)
	if health.value <= 0:
		get_tree().change_scene_to_file("res://main.tscn")

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * kb_power
	velocity = knockbackDirection 
	move_and_slide()
