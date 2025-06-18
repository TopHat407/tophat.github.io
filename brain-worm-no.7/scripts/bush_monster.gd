extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim
@onready var timer: Timer = $wakeup_timer
@onready var detection_area: Area2D = $"detection area"
@onready var chase_area: Area2D = $"chase area"
var counter = 0
@onready var movement_timer: Timer = $movement_timer
var person 
@onready var attack_zone: Area2D = $attack_zone

func _ready() -> void:
	anim.play("underground")
	chase_area.monitoring = false

func _on_detection_area_body_entered(body: Node2D) -> void:
	person = body
	timer.start()
	await timer.timeout
	anim.play("above ground")
	detection_area.monitoring = false
	chase_area.monitoring = true


func _physics_process(delta: float) -> void:
	if counter == 1:
		velocity = (person.global_position - global_position).normalized() * 150
		move_and_slide()


func _on_movement_timer_timeout() -> void:
	velocity.x = randf_range(25, 50)
	velocity.y = randf_range(25, 50)
	move_and_slide()


func _on_chase_area_body_entered(body: Node2D) -> void:
	counter = 1
	attack_zone.monitoring = true

func _on_chase_area_body_exited(body: Node2D) -> void:
	counter = 0
	timer.start()
	await timer.timeout
	anim.play("underground")
	chase_area.monitoring = false
	detection_area.monitoring = true
	attack_zone.monitoring = false


func _on_attack_zone_body_entered(body: Node2D) -> void:
	pass
